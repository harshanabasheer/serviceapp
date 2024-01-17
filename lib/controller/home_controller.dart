import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  List<ServiceModel> ? cleaningServices;
  List ? searchService ;
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  String ? location;

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
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> getAllCleaningServiceController(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      cleaningServices = await apiService.getCleaningService();
      loading = false;
      notifyListeners();

    } catch (error) {
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> searchServiceController(BuildContext context,String query) async {
    try {
      loading = true;
      notifyListeners();
      searchService = await apiService.searchService(query: query);
      loading = false;
      notifyListeners();

    } catch (error) {
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  Future<void> locatePosition() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    placemarkFromCoordinates(currentPosition!.latitude!, _currentPosition!.longitude!)
        .then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        location = placemarks[0].locality;
        notifyListeners();

      }
    });
  }

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    await locatePosition();
    return true;
  }


}