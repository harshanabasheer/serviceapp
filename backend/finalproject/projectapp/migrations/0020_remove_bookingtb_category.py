# Generated by Django 4.2.6 on 2024-01-03 05:34

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0019_servicetb_rating'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='bookingtb',
            name='Category',
        ),
    ]
