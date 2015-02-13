# -*- coding: utf-8 -*-
from django import forms
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from django.utils.translation import ugettext_lazy as _

class RegistrationForm(forms.ModelForm):
    error_messages = {
        'duplicate_email': u'Пользователь с таким Email уже существует',
    }

    password = forms.CharField(label=u'Пароль', widget=forms.PasswordInput)

    class Meta:
        model = get_user_model()
        fields = ('email', 'password', 'fio', 'class_number')

    def clean_email(self):
        email = self.cleaned_data["email"]
        try:
            get_user_model()._default_manager.get(email=email)
        except get_user_model().DoesNotExist:
            return email
        raise forms.ValidationError(
            self.error_messages['duplicate_email'],
            code='duplicate_email',
        )

    def save(self, commit=True):
        user = super(RegistrationForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password"])
        if commit:
            user.save()
        return user

class AdminCreateForm(forms.ModelForm):
    error_messages = {
        'duplicate_email': u"Пользователь с таким Email уже существует",
    }

    password = forms.CharField(label=_("Password"), widget=forms.PasswordInput)

    class Meta:
        model = get_user_model()
        fields = ('email',)

    def clean_email(self):
        email = self.cleaned_data["email"]
        try:
            get_user_model()._default_manager.get(email=email)
        except get_user_model().DoesNotExist:
            return email
        raise forms.ValidationError(
            self.error_messages['duplicate_email'],
            code='duplicate_email',
        )

    def save(self, commit=True):
        user = super(AdminCreateForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password"])
        if commit:
            user.save()
        return user


class AdminUpdateForm(forms.ModelForm):
    password = ReadOnlyPasswordHashField(label=u"Пароль", help_text=u"<a href=\"password/\">сменить пароль</a>.")

    class Meta:
        model = get_user_model()
        exclude = ()

    def __init__(self, *args, **kwargs):
        super(AdminUpdateForm, self).__init__(*args, **kwargs)
        f = self.fields.get('user_permissions', None)
        if f is not None:
            f.queryset = f.queryset.select_related('content_type')

    def clean_password(self):
        return self.initial["password"]
