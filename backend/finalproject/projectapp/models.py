from django.db import models

# Create your models here.
#login table
class LoginTb(models.Model):
    UserName=models.CharField(max_length=50)
    Password=models.CharField(max_length=50)
    Role=models.CharField(max_length=50)
    
    def __str__(self):
        return self.UserName


#registration table
class RegistrationTb(models.Model):
    Name=models.CharField(max_length=50)
    Address=models.CharField(max_length=50,null=True,blank=True)
    Email=models.CharField(max_length=50)
    Phone=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    Password=models.CharField(max_length=50)
    Role=models.CharField(max_length=50)
    City=models.CharField(max_length=50,null=True,blank=True)
    Photo=models.ImageField(upload_to='images/',null=True)
    Category=models.CharField(max_length=50,null=True,blank=True)
    Status=models.CharField(max_length=50)
    Login=models.ForeignKey(LoginTb, on_delete=models.CASCADE)

    def __str__(self):
        return self.Name
    
#category table
class CategoryTb(models.Model):
    CategoryName=models.CharField(max_length=50)
    CategoryImage=models.ImageField(upload_to='images/',null=True)
    def __str__(self):
        return self.CategoryName
    
#service table
class ServiceTb(models.Model):
    ServiceName=models.CharField(max_length=50)
    ServiceImage=models.ImageField(upload_to='images/',null=True)
    Price=models.CharField(max_length=50)
    Description=models.CharField(max_length=5000)
    CategoryId = models.ForeignKey(CategoryTb, on_delete=models.CASCADE)
    Rating = models.CharField(max_length=50)
    
    def __str__(self):
        return self.ServiceName
    
#booking table
class BookingTb(models.Model):
    UserId=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    ServiceId=models.CharField(max_length=50)
    ServiceName=models.CharField(max_length=50)
    ServiceImage=models.ImageField(upload_to='images/',null=True)
    WorkerId=models.CharField(max_length=50,null=True,blank=True)
    WorkerName=models.CharField(max_length=50,null=True,blank=True)
    Date=models.CharField(max_length=50)
    Time=models.CharField(max_length=50)
    Status=models.CharField(max_length=50)
    Address=models.CharField(max_length=50)
    Price=models.CharField(max_length=50)
    
    def __str__(self):
        return self.ServiceName


 
    