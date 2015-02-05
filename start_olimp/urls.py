from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'startolimp.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    (r'^$', 'core.views.Index'),
    # (r'^login/$', 'django.contrib.auth.views.login', {'template_name':'login.html'}),
    # (r'^logout/$', 'django.contrib.auth.views.logout', {'next_page':'/login/'}),

    url(r'^admin/', include(admin.site.urls)),
)
