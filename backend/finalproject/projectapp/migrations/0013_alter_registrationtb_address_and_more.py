# Generated by Django 4.2.6 on 2023-12-28 05:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0012_servicetb_categoryimage'),
    ]

    operations = [
        migrations.AlterField(
            model_name='registrationtb',
            name='Address',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='registrationtb',
            name='City',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
    ]