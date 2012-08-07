from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save

class Question(models.Model):
    comments = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
    image_url = models.CharField(max_length=200)
    user = models.ForeignKey(User)
    tag_string = models.CharField(max_length=200)

    def __unicode__(self):
	return str(self.pk)

class Answer(models.Model):
    question = models.ForeignKey(Question)
    text = models.CharField(max_length=16000)
    user = models.ForeignKey(User)
    image_url = models.CharField(max_length=200,default='')
    pub_date = models.DateTimeField('date published')

    def __unicode__(self):
        return str(self.pk)

class UserData(models.Model):  
    user = models.OneToOneField(User, related_name='userdata')
    access_token = models.CharField(max_length=32)
    profile_image_url = models.CharField(max_length=200)	

    def __unicode__(self):
        return self.user.username

class Tag(models.Model):
    question = models.ForeignKey(Question)
    user = models.ForeignKey(User)

class AnswerLike(models.Model):
     answer = models.ForeignKey(Answer)
     user = models.ForeignKey(User)
     like_date = models.DateTimeField('date like')

     def __unicode__(self):
         return self.user.username + ' likes answer ' + str(self.answer.pk)

class Action(models.Model):
	sender = models.ForeignKey(User,related_name='action_sender')
	question = models.ForeignKey(Question,null=True,blank=True)
	answer = models.ForeignKey(Answer,null=True,blank=True)
	pub_date = models.DateTimeField('action date')
	type = models.CharField(max_length=32)

class ThankYou(models.Model):
	answer = models.ForeignKey(Answer)
	image_url = models.CharField(max_length=200,default='')
	sender = models.ForeignKey(User,related_name='thankyou_sender')
	receiver = models.ForeignKey(User,related_name='thankyou_receiver')

