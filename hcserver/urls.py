from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'hcserver.views.home', name='home'),
    # url(r'^hcserver/', include('hcserver.foo.urls')),
    url(r'^questions/$', 'hcserver.views.index'),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),

    # Create User
    url(r'^create_user/','hcserver.views.create_user'),
    url(r'^login/','hcserver.views.login'),
    
    # Post Question
    url(r'^create_question/','hcserver.views.create_question'),

    # Answers
    url(r'^answers/','hcserver.views.answers'),
)
