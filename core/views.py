from django.shortcuts import render_to_response
from django.template import RequestContext
from users.forms import RegistrationForm

def index(request):
    return render_to_response('index.html', locals(), context_instance=RequestContext(request))

def registration(request):
    form = RegistrationForm()
    return render_to_response('registration.html', locals(), context_instance=RequestContext(request))
