import S3
import hashlib
from django.http import HttpResponse
from django.core import serializers
from hcserver.models import Question
from django.contrib.auth.models import User
from django.utils import simplejson
from django.views.decorators.csrf import csrf_exempt

AWS_ACCESS_KEY_ID = 'AKIAIAUQBYXDQRINBT5Q'
AWS_SECRET_ACCESS_KEY = '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'
BUCKET_NAME = 'halfcanvas'

def index(request):
	json_output = data = serializers.serialize("json", Question.objects.all())
	return HttpResponse(json_output)

@csrf_exempt
def create_user(request):
	postdata = request.POST
	if ('username' in postdata and 'email' in postdata and 'password' in postdata):
		username = postdata['username']
		email = postdata['email']
		password = postdata['password']
	        if (User.objects.filter(username=username).count() > 0):
                	response = dict()
                	response['error_code'] = 10.1
                	response['error_message'] = 'Username ',username,' already exists'
        	elif (User.objects.filter(email=email).count() > 0):
                	response = dict()
                	response['error_code'] = 10.2
                	response['error_message'] = 'Email address is already being used'
        	else:                
			user = User.objects.create_user(username, email, password)
			m = hashlib.md5()
			m.update(username)
			m.update('halfcanvasforkids')
			hash = m.hexdigest()
			response = dict()
			response['errorcode'] = 0
			response['errormesssage'] = ''
			data = dict()
			data['access_token'] = hash
			response['data'] = data
	else:
		response = dict()
		response['errormessage'] = 'Username, email, or password not received'
		response['errorcode'] = 10.3

	return HttpResponse(
        		simplejson.dumps(response),
       			content_type = 'application/javascript; charset=utf8'
    		)

def login(request):
	pass



def upload_question(request):
	#if request.method == 'POST':
	#	form = UploadFileForm(request.POST, request.FILES)
	#	if form.is_valid():
	#handle_uploaded_file(request.FILES['file'])
	return HttpResponse(request.FILES)	
	#conn = S3.AWSAuthConnection('AKIAIAUQBYXDQRINBT5Q','M1R6SrYJcJFxkf8LtzZinu9CQ8Yh9RW6EHEd+yvH')
