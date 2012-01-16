from django.http import HttpResponse
from django.core import serializers
from hcserver.models import Question

def index(request):
	json_output = data = serializers.serialize("json", Question.objects.all())
	return HttpResponse(json_output)