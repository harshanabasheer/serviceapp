# Generated by Django 4.2.6 on 2023-12-08 07:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0002_registrationtb'),
    ]

    operations = [
        migrations.CreateModel(
            name='ServiceTb',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ServiceName', models.CharField(max_length=50)),
                ('ServiceImage', models.ImageField(null=True, upload_to='images/')),
            ],
        ),
    ]