# -*- coding: utf-8 -*-
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .forms import AdminUpdateForm, AdminCreateForm
from .models import MyUser

class MyUserAdmin(UserAdmin):
    add_fieldsets = ((
        None, {
            'classes': ('wide',),
            'fields': ('email', 'password', 'fio')
        }
    ),)
    add_form = AdminCreateForm

    fieldsets = (
        (None, {'fields': ('email', 'password', 'fio', 'class_number')}),
        (u'Права', {'fields': ('is_active', 'is_staff', 'is_superuser')}),
        # (u'Права', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        # (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )
    form = AdminUpdateForm

    list_display = ('email', 'fio', 'is_staff')
    list_filter = ('is_staff', 'is_superuser', 'is_active', 'groups')
    search_fields = ('email', 'fio',)
    ordering = ('email',)
    filter_horizontal = ('groups', 'user_permissions',)

admin.site.register(MyUser, MyUserAdmin)
