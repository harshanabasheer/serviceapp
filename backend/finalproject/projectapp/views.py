from django.shortcuts import render,redirect
from .serializers import LoginSerializers,RegistrationSerializers,ServiceSerializers,BookingSerializers,CategorySerializers,ForgotPasswordSerializer
from .models import LoginTb,RegistrationTb,ServiceTb,BookingTb,CategoryTb
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
import random
from .mail import sendmail

global otp
otp=0

# Create your views here.

#login 
class Login(GenericAPIView):
    serializer_class = LoginSerializers

    def post (self,request):
        u_id= ''
        UserName = request.data.get('UserName')
        Password = request.data.get('Password')
        # print(UserName)
        # print(Password)
        logreg=LoginTb.objects.filter(UserName=UserName,Password=Password)
        # print(logreg,"dddd")
        # print(logreg.count)
        if(logreg.count()>0):
            read_serializer = LoginSerializers(logreg, many=True)
            for i in read_serializer.data:
                id=i['id']
                #print(id)
                
                regdata = RegistrationTb.objects.all().filter(Login = id).values()
                print(regdata)

                for i in regdata:
                    u_id = i['id']
                    name = i['Name']
                    UserName=i['UserName']
                    Password=i['Password']
                    Role=i['Role']
                    Status=i['Status']
                    
                    print(u_id)

                return Response({'data':{
                    'name':name,
                    'userid':u_id,
                    'login_id':id,
                    'UserName':UserName,
                    'Password':Password,
                    'Role':Role,
                    'Status':Status,
                },
                'success':True,
                'message':'Logged In Successfully'
            },status=status.HTTP_200_OK)
        else:
            return Response({
                'message':'username or password is invalid',
                'success':False
                },status = status.HTTP_400_BAD_REQUEST)

#user registraion
class UserReg(GenericAPIView):
    serializer_class=RegistrationSerializers
    login_serializer_class=LoginSerializers
    def post(self, request):
        login_id=""
        Name = request.data.get('Name')
        Address = ""
        Email = request.data.get('Email')
        Phone = request.data.get('Phone')
        Password = request.data.get('Password')
        UserName = Email
        Role="user"
        City = ""
        Photo = request.data.get('Photo')
        Category = ""
        Status='0'
   
        
        if LoginTb.objects.filter(UserName = UserName):
            return Response({'message':'User name allready Exist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
            loginserializer=self.login_serializer_class(data={'UserName':UserName,'Password':Password,'Role':Role})
    
            if loginserializer.is_valid():
                log=loginserializer.save()
                login_id = log.id

            serializer=self.serializer_class(data={'Login':login_id,'Name':Name,'Email':Email,'Phone':Phone,
                                                   'UserName':UserName,'Password':Password,'Role':Role,'Photo':Photo,'Status':Status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'user added successfully','success':True}, status=status.HTTP_200_OK)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
    
     
#get all user   
class GetAllUser(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='user')
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All User','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)

#worker registration
class WorkerReg(GenericAPIView):
    serializer_class=RegistrationSerializers
    login_serializer_class=LoginSerializers
    def post(self, request):
        login_id=""
        Name = request.data.get('Name')
        Address = request.data.get('Address')
        Email = request.data.get('Email')
        Phone = request.data.get('Phone')
        Password = request.data.get('Password')
        UserName = Email
        Role="worker"
        City = request.data.get('City')
        Photo = request.data.get('Photo')
        Category = request.data.get('Category')
        Status='0'
        
        
        
        if LoginTb.objects.filter(UserName = UserName):
            return Response({'message':'User name allready Exist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
            loginserializer=self.login_serializer_class(data={'UserName':UserName,'Password':Password,'Role':Role})
    
            if loginserializer.is_valid():
                log=loginserializer.save()
                login_id = log.id

            serializer=self.serializer_class(data={'Login':login_id,'Name':Name,'Address':Address,'Email':Email,'Phone':Phone,
                                                   'UserName':UserName,'Password':Password,'Role':Role,'City':City,'Photo':Photo,'Status':Status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'user added successfully','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
        
        
#read one user
class GetOneRegister(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        serializer=RegistrationSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Register','success':True},status=status.HTTP_200_OK)
    
#update user
class UpdateRegister(GenericAPIView):
    serializer_class = RegistrationSerializers
    def put(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        data = RegistrationSerializers(instance=queryset, data=request.data,partial=True)
        if data.is_valid():
            data.save()
            return Response(data.data)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)
        
        
#add category    
class AddCategory(GenericAPIView):
    serializer_class=CategorySerializers
    def post(self, request):
        CategoryName = request.data.get('CategoryName')
        CategoryImage = request.data.get('CategoryImage')
        serializer=self.serializer_class(data={'CategoryName':CategoryName,'CategoryImage':CategoryImage})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Category added successfully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
#read categories
class GetAllCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def get(self,request):
        queryset = CategoryTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Category','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
            
#read one category
class GetOneCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def get(self,request,id):
        queryset = CategoryTb.objects.get(pk=id)
        serializer=CategorySerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Category','success':True},status=status.HTTP_200_OK)
    
#delete category
class DeleteCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def delete(self,request,id):
        queryset = CategoryTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':'Category Deleted','success':True},status=status.HTTP_200_OK)      




#add service
class AddService(GenericAPIView):
    serializer_class=ServiceSerializers
    def post(self, request):
        ServiceName = request.data.get('ServiceName')
        ServiceImage = request.data.get('ServiceImage')
        Price = request.data.get('Price')
        Description = request.data.get('Description')
        CategoryId = request.data.get('CategoryId') 
        Rating = request.data.get('Rating') 
        

        serializer=self.serializer_class(data={'ServiceName':ServiceName,'ServiceImage':ServiceImage,'Price':Price,'Description':Description, 'CategoryId': CategoryId,'Rating': Rating})

        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Service added successfully','success':True}, status=status.HTTP_200_OK)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)


#read items
class GetAllService(GenericAPIView):
    serializer_class = ServiceSerializers
    def get(self,request):
        queryset = ServiceTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All service','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
        
#items with category id
class GetCategoryService(GenericAPIView):
    serializer_class = ServiceSerializers
    def get(self,request,id):
        queryset = ServiceTb.objects.filter(CategoryId=id)
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All service','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
            
#read one item
class GetOneService(GenericAPIView):
    serializer_class = ServiceSerializers
    def get(self,request,id):
        queryset = ServiceTb.objects.get(pk=id)
        serializer=ServiceSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Service','success':True},status=status.HTTP_200_OK)
    
#update item
class UpdateService(GenericAPIView):
    serializer_class = ServiceSerializers
    def put(self,request,id):
        queryset = ServiceTb.objects.get(pk=id)
        data = ServiceSerializers(instance=queryset, data=request.data,partial=True)
        if data.is_valid():
            data.save()
            serializer=ServiceSerializers(queryset)
            return Response({'data':serializer.data,'message':'Service upadated successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

#delete item
class DeleteService(GenericAPIView):
    serializer_class = ServiceSerializers
    def delete(self,request,id):
        queryset = ServiceTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':'Service Deleted','success':True},status=status.HTTP_200_OK)
    

class SearchService(GenericAPIView):
    def post(self, request):
        query = request.data.get('query')
        print(query)
        services = ServiceTb.objects.filter(ServiceName__icontains=query)
        data = []

        for service in services:
            service_data = {
                'id': service.id,
                'ServiceName': service.ServiceName,
                'ServiceImage': self.get_image_url(service.ServiceImage),
                'Price': service.Price,
            }
            data.append(service_data)

        return Response({'data': data, 'message': 'Successfully fetched', 'success': True}, status=status.HTTP_200_OK)

    def get_image_url(self, image_name):
      
        return f'/media/{image_name}'
    
    
#admin need to accept worker
class AccepetWorker(GenericAPIView):
    serializer_class = RegistrationSerializers
    def post(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        queryset.Status= 1
        queryset.save()
        serializer=RegistrationSerializers(queryset)
        
        return Response({'data':serializer.data,'message':'Accepted','success':True},status=status.HTTP_200_OK)
    
#get all worker status 1 (accepted by admin)     
class GetAllWorkerAccepted(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='worker',Status='1' )
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Workers','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
        

#place order
class PlaceBooking(GenericAPIView):
    serializer_class = BookingSerializers
    def post(self,request):
        UserId = request.data.get('UserId')
        ServiceId = request.data.get('ServiceId')
        UserName=''
        Address=''
        ServiceName = ''
        Price = ''
        ServiceImage =''
        Status = 0
        Date = request.data.get('Date')
        Time = request.data.get('Time')
       
        
        data = RegistrationTb.objects.filter(Login=UserId).values()
        for i in data:
            Name=i['Name']
            Address=i['Address']
            
        data1 = ServiceTb.objects.filter(id=ServiceId).values()
        print(data1)
        for i in data1:
            ServiceName= i['ServiceName']
            Price=i['Price']
        stb= ServiceTb.objects.get(id=ServiceId)
        service_image = stb.ServiceImage
        
        serializer = self.serializer_class(data={'UserId': UserId,'ServiceId': ServiceId,'UserName': Name,'ServiceName': ServiceName,'Status': Status,'Date': Date,'Status': "0",'Time': Time,'Address':Address,'Price':Price,'ServiceImage': service_image})

        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Service BookedSuccefully','success':True}, status=status.HTTP_200_OK)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    

#read items
class GetAllBooking(GenericAPIView):
    serializer_class = BookingSerializers
    def get(self,request):
        queryset = BookingTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All bookings','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
            
#read one item
class GetOneBooking(GenericAPIView):
    serializer_class = BookingSerializers
    def get(self,request,id):
        queryset = BookingTb.objects.get(pk=id)
        serializer=BookingSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single booking','success':True},status=status.HTTP_200_OK)
    
  
    
#forgotpassword
class FetchMail(GenericAPIView):
    def post(self, request):
        email = request.data.get('email')
        print(email)    
        global otp   
        otp = random.randrange(10001,99999)
        
        print(otp)
        
        sendmail(email,otp)
        return Response({'data': email,'message':'Otp Send Successfully','success': True}, status=status.HTTP_200_OK)
    
#fetchotp
class FetchOtp(GenericAPIView):
    def post(self, request):
        otp1 = request.data.get('otp')
        global otp
        otp2=str(otp)
        print(type(otp1),type(otp2))       
        if(otp2==otp1):
            print("Otp Verified")
            return Response({'data': "Otp Verified",'message':'Otp Verified','success': True}, status=status.HTTP_200_OK)
        else:
            print("Otp not verified")
            return Response({'data':'Otp not verified','success':False},status=status.HTTP_400_BAD_REQUEST)
        
#forgotpassword
class ForgotPassword(GenericAPIView):
    serializer_class = ForgotPasswordSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            username = serializer.validated_data['username']
            new_password = serializer.validated_data['new_password']

            try:
                # Update password in RegistrationTb
                reg_user = RegistrationTb.objects.get(UserName=username)
                reg_user.Password = new_password
                reg_user.save()

                # Update password in LoginTb
                login_user = LoginTb.objects.get(UserName=username)
                login_user.Password = new_password
                login_user.save()

                return Response({'message': 'Password reset successfully', 'success': True}, status=status.HTTP_200_OK)
            except (RegistrationTb.DoesNotExist, LoginTb.DoesNotExist):
                return Response({'message': 'User not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({'message': 'Invalid input', 'success': False}, status=status.HTTP_400_BAD_REQUEST)

        
        
    
    


            
