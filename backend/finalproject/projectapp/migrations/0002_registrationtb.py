# Generated by Django 4.2.6 on 2023-12-08 05:58

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='RegistrationTb',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Name', models.CharField(max_length=50)),
                ('Address', models.CharField(max_length=50)),
                ('Email', models.CharField(max_length=50)),
                ('Phone', models.CharField(max_length=50)),
                ('UserName', models.CharField(max_length=50)),
                ('Password', models.CharField(max_length=50)),
                ('Role', models.CharField(max_length=50)),
                ('City', models.CharField(max_length=50)),
                ('Photo', models.ImageField(null=True, upload_to='images/')),
                ('Category', models.CharField(blank=True, max_length=50, null=True)),
                ('Login', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.logintb')),
            ],
        ),
    ]