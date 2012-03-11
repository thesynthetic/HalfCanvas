from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save

class Question(models.Model):
    description = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
    image_url = models.CharField(max_length=200)
    user = models.ForeignKey(User)

class Answer(models.Model):
    question = models.ForeignKey(Question)
    text = models.CharField(max_length=16000)
    user = models.ForeignKey(User)

class UserData(models.Model):  
    user = models.OneToOneField(User, related_name='userdata')
    access_token = models.CharField(max_length=32)
    profile_image_url = models.CharField(max_length=200)	
