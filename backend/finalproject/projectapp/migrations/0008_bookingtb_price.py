# Generated by Django 4.2.6 on 2023-12-20 13:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0007_servicetb_price'),
    ]

    operations = [
        migrations.AddField(
            model_name='bookingtb',
            name='Price',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]
