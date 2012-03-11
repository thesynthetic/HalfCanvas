from django.contrib import admin
from hcserver.models import Question, Answer, UserData

admin.site.register(Question)
admin.site.register(Answer)
admin.site.register(UserData)

