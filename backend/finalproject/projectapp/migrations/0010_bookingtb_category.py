# Generated by Django 4.2.6 on 2023-12-20 13:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0009_servicetb_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='bookingtb',
            name='Category',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]
