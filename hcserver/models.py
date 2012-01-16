from django.db import models

class Question(models.Model):
    description = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
    image_url = models.CharField(max_length=200)
    user = models.CharField(max_length=30)

class Answer(models.Model):
    question = models.ForeignKey(Question)
    text = models.CharField(max_length=16000)
    user = models.CharField(max_length=30)
