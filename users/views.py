from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import HttpResponseRedirect, Http404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout

from .forms import RegistrationForm

def registration(request):
    if request.user.is_authenticated():
        return HttpResponseRedirect('/')
    else:
        if request.method == 'POST':
            form = RegistrationForm(request.POST, request.FILES)
            if form.is_valid():
                user = form.save()
                return HttpResponseRedirect('/')
        else:
            form = RegistrationForm()
        return render_to_response('registration.html', locals(), context_instance=RequestContext(request))


def login(request):
    email = request.POST['email']
    password = request.POST['password']
    user = authenticate(email=email, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # TODO: check next param
            next_page = request.POST['next']
            return HttpResponseRedirect(next_page)
        else:
            # Return a 'disabled account' error message
            raise Http404()
    else:
        # Return an 'invalid login' error message.
        raise Http404()

def logout(request):
    auth_logout(request)
    return HttpResponseRedirect('/')

