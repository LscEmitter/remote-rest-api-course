# Generated by Django 2.2 on 2022-04-29 08:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('profiles_api', '0004_auto_20220429_0829'),
    ]

    operations = [
        migrations.AddField(
            model_name='profilefeeditem',
            name='changed_od',
            field=models.DateTimeField(auto_now=True),
        ),
        migrations.AlterField(
            model_name='profilefeeditem',
            name='created_on',
            field=models.DateTimeField(auto_now_add=True),
        ),
    ]
