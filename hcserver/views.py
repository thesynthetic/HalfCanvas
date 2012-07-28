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

#Error 10.0 - User Creation
#Error 10.1 - Username is already being used
#Error 10.2 - Email address is already being used
#Error 10.3 - Username, email, or password not received


@csrf_exempt
def index(request):
	output = dict()
	question_list = []
	action_list = []

	if('start' in request.POST and 'end' in request.POST):
		start_index = request.POST['start']
		end_index = request.POST['end']
	else:
		start_index = 0
		end_index = 9

	if('access_token' in request.POST):
		user_data = UserData.objects.get(access_token = request.POST['access_token'])
		if user_data is not None:
			for i in Action.objects.filter( Q(question__user=user_data.user) | Q(answer__user=user_data.user)  ).select_related('user__userdata'):
				action = dict()
				action['answer_id'] = i.answer.pk
				action['question_id'] = i.answer.question.pk

				if (i.question is not None):
					action['receiver'] = i.question.user.username
				else:
					action['receiver'] = i.answer.user.username
				action['sender'] = i.sender.username
				action['sender_image_url'] = i.sender.userdata.profile_image_url
				action['type'] = i.type
				action_list.append(action)
			output['action_list'] = action_list
		else:
			output['action_list'] = None	
	for i in Question.objects.select_related('user__userdata').all().order_by('-pub_date')[start_index:end_index].annotate(answer_count=Count('answer')):
		question = dict()
		question['image_url'] = i.image_url
		question['username'] = i.user.username
		question['description'] = i.description
		question['user_profile_image_url'] = i.user.userdata.profile_image_url
		question['question_id'] = i.pk
		question['answer_count'] = i.answer_count
		question['pub_life'] = pretty_date(i.pub_date)
		question_list.append(question)
	
	output['question_list'] = question_list


	return HttpResponse(
               	        simplejson.dumps(output),
               	        content_type = 'application/javascript; charset=utf8'
               	)
	
@csrf_exempt
def answers(request):
	if request.POST['question_id']:
		output = []
		userlikes = []
		if ('access_token' in request.POST):
			user_data = UserData.objects.get(access_token=request.POST['access_token'])
			if user_data is not None:
				q = Question.objects.get(pk=request.POST['question_id'])
				fn = lambda x: x.answer
				userlikes = map(fn, AnswerLike.objects.filter(Q(user=user_data.user) & Q(answer__question=q)))
				
		for i in Answer.objects.filter(question__pk=request.POST['question_id']).order_by('pub_date').select_related('user__userdata').select_related('answer_answerlike').annotate(like_count=Count('answerlike')):

			answer = dict()
               		answer['image_url'] = i.image_url
                	answer['username'] = i.user.username
                	answer['text'] = i.text
                	answer['user_profile_image_url'] = i.user.userdata.profile_image_url
                	answer['answer_id'] = i.pk
                	answer['like_count'] = i.like_count
			if i in userlikes:
				answer['like_toggle'] = 1
			else:
				answer['like_toggle'] = 0
			#answer['pub_date'] = i.pub_date
                	output.append(answer)
        	return HttpResponse(
                	        simplejson.dumps(output),
                        	content_type = 'application/javascript; charset=utf8'
                	)
	else:
		#Todo: Handle error
		return HttpResponse()


@csrf_exempt
def create_question(request):
	#Many more validation steps must be implemented here
	if request.method == 'POST':
		if request.FILES:
			access_token = request.POST['access_token']
                        user_data = UserData.objects.get(access_token = access_token)			
			
			#Connect to S3
			conn= boto.connect_s3()
			bucket = conn.get_bucket('dittles')
			k = Key(bucket)

			#Create filename for S3
			s3_key = datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f') + user_data.user.username +'.jpg' 
			k.key = 'problems/' + s3_key
			k.set_metadata("Content-Type", 'image/jpeg')
			dict_keys = request.FILES.keys()
			k.set_contents_from_string(request.FILES[dict_keys[0]].read())
			
			#Store Question metadata in DB
			image_url = 'https://s3.amazonaws.com/dittles/' + k.key 
			q = Question(user=user_data.user, image_url=image_url, pub_date=datetime.datetime.now())
			q.save()
			
		return HttpResponse(request.FILES[dict_keys[0]].read())
	else:
		return HttpResponse("Nothing, just nothing!")

@csrf_exempt
def create_answer(request):
	if request.method == 'POST':
                if request.FILES:
                        access_token = request.POST['access_token']
                        user_data = UserData.objects.get(access_token = access_token)
			
                        #Connect to S3
                        conn= boto.connect_s3()
                        bucket = conn.get_bucket('dittles')
                        k = Key(bucket)

                        #Create filename for S3
                        s3_key = datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f') + user_data.user.username +'.jpg'
                        k.key = 'answers/' + s3_key
                        k.set_metadata("Content-Type", 'image/jpeg')
                        dict_keys = request.FILES.keys()
                        k.set_contents_from_string(request.FILES[dict_keys[0]].read())
			
                        #Store Question metadata in DB
                        image_url = 'https://s3.amazonaws.com/dittles/' + k.key
			text = ''
                        if ('text' in request.POST):
				text = request.POST['text']
			if ('question_id' in request.POST):
				question_id = request.POST['question_id']
			else:
				return HttpResponse('Question_id not found in post')
			q = Question.objects.get(id=question_id)
			a = Answer(question=q, text=text, user=user_data.user, image_url=image_url, pub_date=datetime.datetime.now())
                        a.save()
			action = Action(sender=user_data.user, question=q, answer=a, pub_date=datetime.datetime.now(), type='answer')
			action.save()

                return HttpResponse(request.FILES[dict_keys[0]].read())
        else:
                return HttpResponse("Nothing, just nothing!")

@csrf_exempt
def create_video_answer(request):
        if request.method == 'POST':
                if request.FILES:
                        access_token = request.POST['access_token']
                        user_data = UserData.objects.get(access_token = access_token)

                        #Connect to S3
                        conn= boto.connect_s3()
                        bucket = conn.get_bucket('dittles')
                        k = Key(bucket)

                        #Create filename for S3
                        s3_key = datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f') + user_data.user.username +'.mp4'
                        k.key = 'video/' + s3_key
                        k.set_metadata("Content-Type", 'video/mp4')
                        dict_keys = request.FILES.keys()
                        k.set_contents_from_string(request.FILES[dict_keys[0]].read())

                        #Store Question metadata in DB
                        image_url = 'https://s3.amazonaws.com/dittles/' + k.key
                        text = ''
                        if ('text' in request.POST):
                                text = request.POST['text']
                        if ('question_id' in request.POST):
                                question_id = request.POST['question_id']
                        else:
                                return HttpResponse('Question_id not found in post')
                        q = Question.objects.get(id=question_id)
			a = Answer(question=q, text=text, user=user_data.user, image_url=image_url, pub_date=datetime.datetime.now())
                        a.save()
			action = Action(sender=user_data.user,question=q, answer=a, pub_date=datetime.datetime.now(), type='answer')
			action.save()
                return HttpResponse(request.FILES[dict_keys[0]].read())
        else:
                return HttpResponse("Nothing, just nothing!")


@csrf_exempt
def like_answer(request):
	if request.method == 'POST':
		if 'answer_id' in request.POST and 'access_token' in request.POST:
			access_token = request.POST['access_token']
			user_data = UserData.objects.get(access_token = access_token)
			answer_id = request.POST['answer_id']
			answer = Answer.objects.get(pk=answer_id)
			like = AnswerLike(answer=answer,user=user_data.user, like_date=datetime.datetime.now())
			like.save()
			action = Action(sender=user_data.user, question=answer.question, answer=answer, pub_date=datetime.datetime.now(),type='like')
			action.save() 
			return HttpResponse('AnswerLike created')
		else:
			return HttpResponse('Answer_id and/or access_token not posted')
	else:
		return HttpResponse('Answer_id and/or access_token not posteod')

@csrf_exempt
def unlike_answer(request):
	if request.method == 'POST':
		if 'answer_id' in request.POST and 'access_token' in request.POST:
			access_token = request.POST['access_token']
			user_data = UserData.objects.get(access_token = access_token)
			answer_id = request.POST['answer_id']
			answer = Answer.objects.get(pk=answer_id)
			try:
				like = AnswerLike.objects.get(answer=answer, user=user_data.user)
				like.delete()
				action = Action.objects.get(sender=user_data.user,question=answer.question, answer=answer, type='like')
				action.delete()
				return HttpResponse('AnswerLike deleted')
			except DoesNotExist:
				return HttpResponse('AnswerLike does not exist (cannot be unliked)')
		else:
			return HttpResponse('Answer_id and/or access_token not posted')
	else:
		return HttpResponse('Answer_id and/or access_token not posted')
