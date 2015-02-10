# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('auth', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='MyUser',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(default=django.utils.timezone.now, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('email', models.EmailField(unique=True, max_length=255, verbose_name='Email', db_index=True)),
                ('is_staff', models.BooleanField(default=False, verbose_name='\u0414\u043e\u0441\u0442\u0443\u043f \u0432 \u0430\u0434\u043c\u0438\u043d\u043a\u0443')),
                ('is_active', models.BooleanField(default=True, verbose_name='\u0410\u043a\u0442\u0438\u0432\u0435\u043d')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='\u0414\u0430\u0442\u0430 \u0440\u0435\u0433\u0438\u0441\u0442\u0440\u0430\u0446\u0438\u0438')),
                ('fio', models.TextField(max_length=255, verbose_name='\u0424\u0418\u041e')),
                ('class_number', models.TextField(max_length=255, verbose_name='\u041a\u043b\u0430\u0441\u0441')),
                ('groups', models.ManyToManyField(related_query_name='user', related_name='user_set', to='auth.Group', blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of his/her group.', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(related_query_name='user', related_name='user_set', to='auth.Permission', blank=True, help_text='Specific permissions for this user.', verbose_name='user permissions')),
            ],
            options={
                'abstract': False,
                'verbose_name': 'user',
                'swappable': 'AUTH_USER_MODEL',
                'verbose_name_plural': 'users',
            },
            bases=(models.Model,),
        ),
    ]
