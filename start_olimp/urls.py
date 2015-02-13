from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),

    (r'^$', 'core.views.index'),
)

urlpatterns += patterns('users',
    (r'^registration/$', 'views.registration'),
    (r'^login/$', 'views.login'),
    (r'^logout/$', 'views.logout'),
)
