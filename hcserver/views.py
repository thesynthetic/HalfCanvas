import S3
import hashlib
from django.http import HttpResponse
from django.core import serializers
from hcserver.models import Question, Answer, UserData
from django.contrib.auth.models import User
from django.utils import simplejson
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate

AWS_ACCESS_KEY_ID = 'AKIAIAUQBYXDQRINBT5Q'
AWS_SECRET_ACCESS_KEY = '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'
BUCKET_NAME = 'halfcanvas'

#Error 9.0 - Login
#Error 9.1 - Username and password is incorrect
#Error 9.2 - User is not active
#Error 9.3 - Username or password not received

#Error 10.0 - User Creation
#Error 10.1 - Username is already being used
#Error 10.2 - Email address is already being used
#Error 10.3 - Username, email, or password not received



def index(request):
	output = []
	for i in Question.objects.select_related('user__userdata').all().order_by('-pub_date'):
		question = dict()
		question['image_url'] = i.image_url
		question['username'] = i.user.username
		question['description'] = i.description
		question['user_profile_image_url'] = i.user.userdata.profile_image_url
		question['question_id'] = i.pk
		#question['pub_date'] = i.pub_date
		output.append(question)
	#json_output = data = serializers.serialize("json", Question.objects.all())
	#return HttpResponse(json_output)
	return HttpResponse(
                        simplejson.dumps(output),
                        content_type = 'application/javascript; charset=utf8'
                )

@csrf_exempt
def create_user(request):
	postdata = request.POST
	if ('username' in postdata and 'email' in postdata and 'password' in postdata):
		username = postdata['username']
		email = postdata['email']
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
			
			m = hashlib.md5()
			m.update(username)
			m.update('halfcanvasforkids')
			access_token = m.hexdigest()
			userData = UserData(user=user, access_token=access_token, profile_image_url='')
			userData.save()
			response = dict()
			response['errorcode'] = '0'
			response['errormesssage'] = ''
			data = dict()
			data['access_token'] = access_token
			response['data'] = data
	else:
		response = dict()
		response['errormessage'] = 'Username, email, or password not received'
		response['errorcode'] = '10.3'

	return HttpResponse(
        		simplejson.dumps(response),
       			content_type = 'application/javascript; charset=utf8'
    		)

@csrf_exempt
def login(request):
	postdata = request.POST
        if ('username' in postdata and 'password' in postdata):
                username = postdata['username']
                password = postdata['password']
                user = authenticate(username=username, password=password)
		if user is not None:
			if user.is_active:
				userData = UserData.objects.get(user=user)
				response = dict()
				response['errorcode'] = '0'
				response['errormessage'] = ''
				data = dict()
				data['access_token'] = userData.access_token
				response['data'] = data
			else:
				response = dict()
                                response['errorcode'] = '9.2'
                                response['errormessage'] = 'User is not active'
		else:
			response = dict()
                       	response['errorcode'] = '9.1'
                      	response['errormessage'] = 'Username and password incorrect'
        else:
                response = dict()
                response['errormessage'] = 'Username and password not received'
                response['errorcode'] = '9.3'
	return HttpResponse(
			simplejson.dumps(response),
                        content_type = 'application/javascript; charset=utf8'
                )
@csrf_exempt
def post(request):
	if request.method == 'POST':
		if request.FILES['file']:
			from boto.s3.key import Key
			k = Key(bucket)
			k.key = 'foobar'
			k.set_contents_from_string('This is a test of S3')





		return HttpResponse(simplejson.dumps(request.FILES))
	else:
		return HttpResponse("Nothing, just nothing!")
