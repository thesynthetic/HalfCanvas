import hashlib
from django.http import HttpResponse
from django.core import serializers
from hcserver.models import Question, Answer, UserData, Action, AnswerLike
from django.contrib.auth.models import User
from django.utils import simplejson
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate
from django.db.models import Count, Q
from hcserver.util import *
import boto
import datetime
from boto.s3.key import Key


#Error 9.0 - Login
#Error 9.1 - Username and password is incorrect
#Error 9.2 - User is not active
#Error 9.3 - Username or password not received
#Error 9.4 - Access token not received

#Error 10.0 - User Creation
#Error 10.1 - Username is already being used
#Error 10.2 - Email address is already being used
#Error 10.3 - Username, email, or password not received
#Error 10.4 - Profile Picture not provided

@csrf_exempt
def create_user(request):
	postdata = request.POST
	if ('username' in postdata and 'email' in postdata and 'password' in postdata and request.FILES): 
		username = postdata['username'].lower()
		email = postdata['email'].lower()
		password = postdata['password']
	        if (User.objects.filter(username=username).count() > 0):
                	response = dict()
                	response['error_code'] = '10.1'
                	response['error_message'] = 'Username is already being used'
        	elif (User.objects.filter(email=email).count() > 0):
                	response = dict()
                	response['error_code'] = '10.2'
                	response['error_message'] = 'Email address is already being used'
        	else:                
			user = User.objects.create_user(username, email, password)

                        #Connect to S3
                        conn= boto.connect_s3()
                        bucket = conn.get_bucket('halfcanvas')
                        k = Key(bucket)

                        #Create filename for S3
                        s3_key = username +'.jpg'
                        k.key = 'users/' + s3_key
                        k.set_metadata("Content-Type", 'image/jpeg')
                        dict_keys = request.FILES.keys()
                        k.set_contents_from_string(request.FILES[dict_keys[0]].read())

                        #Store Question metadata in DB
                        image_url = 'https://s3.amazonaws.com/halfcanvas/' + k.key
                       	
			m = hashlib.md5()
			m.update(username)
			m.update('halfcanvasforkids')
			access_token = m.hexdigest()
			userData = UserData(user=user, access_token=access_token, profile_image_url=image_url)
			userData.save()
			response = dict()
			response['error_code'] = '0'
			response['error_messsage'] = ''
			data = dict()
			data['access_token'] = access_token
			response['data'] = data
	else:
		response = dict()
		response['error_message'] = 'Username, email, password, or profile picture not received'
		response['error_code'] = '10.3'

	return HttpResponse(
        		simplejson.dumps(response),
       			content_type = 'application/javascript; charset=utf8'
    		)

@csrf_exempt
def login(request):
	postdata = request.POST
        if ('username' in postdata and 'password' in postdata):
                username = postdata['username'].lower()
                password = postdata['password']
                user = authenticate(username=username, password=password)
		if user is not None:
			if user.is_active:
				userData = UserData.objects.get(user=user)
				response = dict()
				response['error_code'] = '0'
				response['error_message'] = ''
				data = dict()
				data['access_token'] = userData.access_token
				response['data'] = data
			else:
				response = dict()
                                response['error_code'] = '9.2'
                                response['error_message'] = 'User is not active'
		else:
			response = dict()
                       	response['error_code'] = '9.1'
                      	response['error_message'] = 'Username and password incorrect'
        else:
                response = dict()
                response['error_message'] = 'Username and password not received'
                response['error_code'] = '9.3'
	return HttpResponse(
			simplejson.dumps(response),
                        content_type = 'application/javascript; charset=utf8')

@csrf_exempt
def change_profile_picture(request):
	postdata = request.POST
	response = dict()
	userdata = None
	if ('access_token' in postdata):
		access_token = postdata['access_token']
		userdata = UserData.objects.get(access_token=access_token)
		if userdata is not None:
			user = userdata.user
		else:
			response['error_code'] = '9.2'
                	response['error_message'] = 'User is not active'   
                	return HttpResponse(simplejson.dumps(response),
                                    content_type = 'application/javascript; charset=utf8')
	else:
		response['error_code'] = '9.4'
		response['error_message'] = 'Access token not received'
		return HttpResponse(simplejson.dumps(response), 
		                    content_type = 'application/javascript; charset=utf8')
	if (request.FILES):
		
		#Connect to S3
		conn= boto.connect_s3()
                bucket = conn.get_bucket('dittles')
                k = Key(bucket)
		
                #Create filename for S3
                s3_key = userdata.user.username +'.jpg'
                k.key = 'users/' + s3_key
                k.set_metadata("Content-Type", 'image/jpeg')
                dict_keys = request.FILES.keys()
                k.set_contents_from_string(request.FILES[dict_keys[0]].read(),replace=True)

                #Store Question metadata in DB
                image_url = 'https://s3.amazonaws.com/dittles/' + k.key

                response = dict()
                response['new_image_url'] = image_url
		response['error_code'] = '0'
                response['error_messsage'] = ''
	else:
		response['error_code'] = '10.4'
		response['error_message'] = 'Profile picture not provided'
	return HttpResponse(
			simplejson.dumps(response),
			content_type = 'application/javascript; charset=utf8')	
