import 'package:flutter/material.dart';

import '../model/category_model.dart';
import '../model/service_model.dart';
import '../routes/rout_name.dart';
import '../services/api_services.dart';

class HomeController extends ChangeNotifier{
  bool loading = false;
  final ApiService apiService = ApiService();
  CategoryModel ? categories ;
  List<ServiceModel> ? services;
  ServiceModel ? oneService;
  List<ServiceModel> ? recommentedServices;

  Future<void> getAllCategoriesController() async {
    try {
      loading = true;
      notifyListeners();
      categories = await apiService.getAllCategories();

      loading = false;
      notifyListeners();
    } catch (error) {
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> getAllServiceController(BuildContext context, int categoryId) async {
    try {
      loading = true;
      notifyListeners();
      services = await apiService.getAllService(categoryId);
      loading = false;
      notifyListeners();

    } catch (error) {

      services = null;
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> getOneServiceController(BuildContext context, int serviceId) async {
    try {
      loading = true;
      notifyListeners();
      oneService = await apiService.getOneService(serviceId);
      loading = false;
      notifyListeners();

    } catch (error) {

      services = null;
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> getRecommentedServiceController(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      recommentedServices = await apiService.recommentedService();
      loading = false;
      notifyListeners();
    } catch (error) {
      services = null;
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

}