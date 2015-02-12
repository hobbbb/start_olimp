# -*- coding: utf-8 -*-
# https://github.com/jcugat/django-custom-user

from django.db import models
from django.contrib.auth.models import (AbstractBaseUser, BaseUserManager, PermissionsMixin)
from django.core.mail import send_mail
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _

class MyUserManager(BaseUserManager):
    def _create_user(self, email, password, is_staff, is_superuser, **extra_fields):
        if not email:
            raise ValueError(u'Не указан Email')

        now = timezone.now()
        email = self.normalize_email(email)
        is_active = extra_fields.pop("is_active", True)
        user = self.model(email=email, is_staff=is_staff, is_active=is_active, is_superuser=is_superuser, last_login=now, date_joined=now, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        is_staff = extra_fields.pop("is_staff", False)
        return self._create_user(email, password, is_staff, False, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        return self._create_user(email, password, True, True, **extra_fields)


class AbstractMyUser(AbstractBaseUser, PermissionsMixin):
    email           = models.EmailField(u'Email', max_length=255, unique=True, db_index=True)
    is_staff        = models.BooleanField(u'Доступ в админку', default=False)
    is_active       = models.BooleanField(u'Активен', default=True)
    date_joined     = models.DateTimeField(u'Дата регистрации', default=timezone.now)
    fio             = models.CharField(u'ФИО', max_length=255)
    class_number    = models.CharField(u'Класс', max_length=255)

    objects = MyUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['fio']

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')
        abstract = True

    def get_full_name(self):
        return self.fio

    def get_short_name(self):
        return self.fio

    def email_user(self, subject, message, from_email=None, **kwargs):
        send_mail(subject, message, from_email, [self.email], **kwargs)


class MyUser(AbstractMyUser):
    class Meta(AbstractMyUser.Meta):
        swappable = 'AUTH_USER_MODEL'
