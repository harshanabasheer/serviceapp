# Generated by Django 4.2.6 on 2023-12-29 13:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0013_alter_registrationtb_address_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='CategoryTb',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Category', models.CharField(max_length=50)),
                ('CategoryImage', models.ImageField(null=True, upload_to='images/')),
            ],
        ),
        migrations.RemoveField(
            model_name='servicetb',
            name='Category',
        ),
        migrations.RemoveField(
            model_name='servicetb',
            name='CategoryImage',
        ),
    ]
