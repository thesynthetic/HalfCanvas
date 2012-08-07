from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from django.contrib.auth import views as auth_views
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^password_reset/$', auth_views.password_reset, name='password_reset'),
   url (r'^password_reset_done/$', auth_views.password_reset_done,name='password_reset_done'),
   url (r'^password_reset_confirm/(?P<uidb36>[0-9A-Za-z]+)/(?P<token>.+)/$', auth_views.password_reset_confirm, name='password_reset_confirm'),
    url(r'^password_reset_complete/$', auth_views.password_reset_complete, name='password_reset_complete'),
)

urlpatterns += patterns('',
    # Examples:
    # url(r'^$', 'hcserver.views.home', name='home'),
    # url(r'^hcserver/', include('hcserver.foo.urls')),
    url(r'^questions/$', 'hcserver.views.index'),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),

    # Create User
    url(r'^create_user/','hcserver.account_views.create_user'),
    url(r'^login/','hcserver.account_views.login'),
    url(r'^change_profile_picture','hcserver.account_views.change_profile_picture'),
    
    # Post Question
    url(r'^create_question/','hcserver.views.create_question'),

    # Answers
    url(r'^answers/','hcserver.views.answers'),

    # Create Answer
    url(r'^create_answer/','hcserver.views.create_answer'),

    # Create Video Answer
    url(r'^create_video_answer/','hcserver.views.create_video_answer'),

    # Like Answer
    url(r'^like_answer/','hcserver.views.like_answer'),

    # Unlike Answer
    url(r'^unlike_answer/','hcserver.views.unlike_answer'),

    # Questions Asked by a Certain User
    url(r'user_questions/','hcserver.views.user_questions'),

    # Answers Asked by a Ceratin User
    url(r'user_answers/','hcserver.views.user_answers'),

    # Answers Liked by a Certain User
    url(r'user_answer_likes/','hcserver.views.user_answer_likes'),
)
