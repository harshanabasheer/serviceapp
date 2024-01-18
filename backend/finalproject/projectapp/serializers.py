from rest_framework import serializers
from .models import LoginTb,RegistrationTb,ServiceTb,BookingTb,CategoryTb

class LoginSerializers(serializers.ModelSerializer):
    class Meta:
        model = LoginTb
        fields = '__all__'
    def create(self,validated_data):
        return LoginTb.objects.create(**validated_data)
    
class RegistrationSerializers(serializers.ModelSerializer):
    class Meta:
        model = RegistrationTb
        fields = '__all__'
    def create(self,validated_data):
        return RegistrationTb.objects.create(**validated_data)
    
class CategorySerializers(serializers.ModelSerializer):
    class Meta:
        model = CategoryTb
        fields = '__all__'
    def create(self,validated_data):
        return CategoryTb.objects.create(**validated_data)

class ServiceSerializers(serializers.ModelSerializer):
    CategoryName = serializers.SerializerMethodField()
    class Meta:
        model = ServiceTb
        fields = [f.name for f in ServiceTb._meta.get_fields()]
        fields.append('CategoryName')
        
    def get_CategoryName(self, obj):
        return obj.CategoryId.CategoryName

    def create(self, validated_data):
        return ServiceTb.objects.create(**validated_data)


    
class BookingSerializers(serializers.ModelSerializer):
    class Meta:
        model = BookingTb
        fields = '__all__'
    def create(self,validated_data):
        return BookingTb.objects.create(**validated_data)
    
class ForgotPasswordSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=255)
    new_password = serializers.CharField(write_only=True)
    