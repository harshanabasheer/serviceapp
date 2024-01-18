from django.urls import path
from . import views

urlpatterns = [
    path('Login',views.Login.as_view(),name='Login'),
    path('UserReg',views.UserReg.as_view(),name='UserReg'),
    path('WorkerReg',views.WorkerReg.as_view(),name='WorkerReg'),
    path('GetOneRegister/<int:id>',views.GetOneRegister.as_view(),name='GetOneRegister'),
    path('UpdateRegister/<int:id>',views.UpdateRegister.as_view(),name='UpdateRegister'),
    path('GetAllUser',views.GetAllUser.as_view(),name='GetAllUser'),
    path('AddService',views.AddService.as_view(),name='AddService'),
    path('GetAllService',views.GetAllService.as_view(),name='GetAllService'),
    path('GetOneService/<int:id>',views.GetOneService.as_view(),name='GetOneService'),
    path('UpdateService/<int:id>',views.UpdateService.as_view(),name='UpdateService'),
    path('DeleteService/<int:id>',views.DeleteService.as_view(),name='DeleteService'),
    path('DeleteService/<int:id>',views.DeleteService.as_view(),name='DeleteService'),
    path('AccepetWorker/<int:id>',views.AccepetWorker.as_view(),name='AccepetWorker'),
    path('GetAllWorkerAccepted',views.GetAllWorkerAccepted.as_view(),name='GetAllWorkerAccepted'),
    path('PlaceBooking',views.PlaceBooking.as_view(),name='PlaceBooking'),
    path('FetchMail',views.FetchMail.as_view(),name='FetchMail'),
    path('FetchOtp',views.FetchOtp.as_view(),name='FetchOtp'),
    path('GetAllBooking',views.GetAllBooking.as_view(),name='GetAllBooking'),
    path('GetOneBooking/<int:id>',views.GetOneBooking.as_view(),name='GetOneBooking'),
    path('AddCategory',views.AddCategory.as_view(),name='AddCategory'),
    path('GetAllCategory',views.GetAllCategory.as_view(),name='GetAllCategory'),
    path('GetOneCategory/<int:id>',views.GetOneCategory.as_view(),name='GetOneCategory'),
    path('DeleteCategory/<int:id>',views.DeleteCategory.as_view(),name='DeleteCategory'),
    path('GetCategoryService/<int:id>',views.GetCategoryService.as_view(),name='GetCategoryService'),
    path('SearchService',views.SearchService.as_view(),name='SearchService'),
    path('ForgotPassword',views.ForgotPassword.as_view(),name='ForgotPassword'),
    
  
]
