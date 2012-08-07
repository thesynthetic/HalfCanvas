# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'Question'
        db.create_table('hcserver_question', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('description', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('pub_date', self.gf('django.db.models.fields.DateTimeField')()),
            ('image_url', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
        ))
        db.send_create_signal('hcserver', ['Question'])

        # Adding model 'Answer'
        db.create_table('hcserver_answer', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('question', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Question'])),
            ('text', self.gf('django.db.models.fields.CharField')(max_length=16000)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('image_url', self.gf('django.db.models.fields.CharField')(default='', max_length=200)),
            ('pub_date', self.gf('django.db.models.fields.DateTimeField')()),
        ))
        db.send_create_signal('hcserver', ['Answer'])

        # Adding model 'UserData'
        db.create_table('hcserver_userdata', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user', self.gf('django.db.models.fields.related.OneToOneField')(related_name='userdata', unique=True, to=orm['auth.User'])),
            ('access_token', self.gf('django.db.models.fields.CharField')(max_length=32)),
            ('profile_image_url', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal('hcserver', ['UserData'])

        # Adding model 'Tag'
        db.create_table('hcserver_tag', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('question', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Question'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
        ))
        db.send_create_signal('hcserver', ['Tag'])

        # Adding model 'AnswerLike'
        db.create_table('hcserver_answerlike', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('answer', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Answer'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('like_date', self.gf('django.db.models.fields.DateTimeField')()),
        ))
        db.send_create_signal('hcserver', ['AnswerLike'])

        # Adding model 'Action'
        db.create_table('hcserver_action', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('sender', self.gf('django.db.models.fields.related.ForeignKey')(related_name='action_sender', to=orm['auth.User'])),
            ('question', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Question'], null=True, blank=True)),
            ('answer', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Answer'], null=True, blank=True)),
            ('pub_date', self.gf('django.db.models.fields.DateTimeField')()),
            ('type', self.gf('django.db.models.fields.CharField')(max_length=32)),
        ))
        db.send_create_signal('hcserver', ['Action'])

        # Adding model 'ThankYou'
        db.create_table('hcserver_thankyou', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('answer', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['hcserver.Answer'])),
            ('image_url', self.gf('django.db.models.fields.CharField')(default='', max_length=200)),
            ('sender', self.gf('django.db.models.fields.related.ForeignKey')(related_name='thankyou_sender', to=orm['auth.User'])),
            ('receiver', self.gf('django.db.models.fields.related.ForeignKey')(related_name='thankyou_receiver', to=orm['auth.User'])),
        ))
        db.send_create_signal('hcserver', ['ThankYou'])


    def backwards(self, orm):
        
        # Deleting model 'Question'
        db.delete_table('hcserver_question')

        # Deleting model 'Answer'
        db.delete_table('hcserver_answer')

        # Deleting model 'UserData'
        db.delete_table('hcserver_userdata')

        # Deleting model 'Tag'
        db.delete_table('hcserver_tag')

        # Deleting model 'AnswerLike'
        db.delete_table('hcserver_answerlike')

        # Deleting model 'Action'
        db.delete_table('hcserver_action')

        # Deleting model 'ThankYou'
        db.delete_table('hcserver_thankyou')


    models = {
        'auth.group': {
            'Meta': {'object_name': 'Group'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'auth.permission': {
            'Meta': {'ordering': "('content_type__app_label', 'content_type__model', 'codename')", 'unique_together': "(('content_type', 'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'hcserver.action': {
            'Meta': {'object_name': 'Action'},
            'answer': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Answer']", 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'pub_date': ('django.db.models.fields.DateTimeField', [], {}),
            'question': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Question']", 'null': 'True', 'blank': 'True'}),
            'sender': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'action_sender'", 'to': "orm['auth.User']"}),
            'type': ('django.db.models.fields.CharField', [], {'max_length': '32'})
        },
        'hcserver.answer': {
            'Meta': {'object_name': 'Answer'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image_url': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '200'}),
            'pub_date': ('django.db.models.fields.DateTimeField', [], {}),
            'question': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Question']"}),
            'text': ('django.db.models.fields.CharField', [], {'max_length': '16000'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'hcserver.answerlike': {
            'Meta': {'object_name': 'AnswerLike'},
            'answer': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Answer']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'like_date': ('django.db.models.fields.DateTimeField', [], {}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'hcserver.question': {
            'Meta': {'object_name': 'Question'},
            'description': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image_url': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'pub_date': ('django.db.models.fields.DateTimeField', [], {}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'hcserver.tag': {
            'Meta': {'object_name': 'Tag'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'question': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Question']"}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'hcserver.thankyou': {
            'Meta': {'object_name': 'ThankYou'},
            'answer': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['hcserver.Answer']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image_url': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '200'}),
            'receiver': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'thankyou_receiver'", 'to': "orm['auth.User']"}),
            'sender': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'thankyou_sender'", 'to': "orm['auth.User']"})
        },
        'hcserver.userdata': {
            'Meta': {'object_name': 'UserData'},
            'access_token': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'profile_image_url': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'user': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'userdata'", 'unique': 'True', 'to': "orm['auth.User']"})
        }
    }

    complete_apps = ['hcserver']
