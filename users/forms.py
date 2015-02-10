# -*- coding: utf-8 -*-
from django import forms
from models import MyUser

class RegistrationForm(forms.Form):
    # required_css_class = 'required'

    class Meta:
        model = MyUser
        fields = ('email', 'password', 'fio', 'class_number')

    email        = forms.CharField(label=u'Email')
    password     = forms.CharField(label=u'Пароль')
    fio          = forms.CharField(label=u'ФИО')
    class_number = forms.CharField(label=u'Класс')
