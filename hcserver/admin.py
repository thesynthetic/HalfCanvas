from django.contrib import admin
from hcserver.models import Question, Answer, UserData, AnswerLike, Tag, Action, ThankYou

admin.site.register(Question)
admin.site.register(Answer)
admin.site.register(UserData)
admin.site.register(AnswerLike)
admin.site.register(Tag)
admin.site.register(Action)
admin.site.register(ThankYou)

