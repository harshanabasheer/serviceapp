from django.contrib import admin
from.models import LoginTb,RegistrationTb,ServiceTb,BookingTb,CategoryTb
# Register your models here.
admin.site.register(LoginTb)
admin.site.register(RegistrationTb)
admin.site.register(ServiceTb)
admin.site.register(BookingTb)
admin.site.register(CategoryTb)