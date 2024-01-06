import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../model/booking_model.dart';
import '../routes/rout_name.dart';
import '../services/api_services.dart';

class BookingController extends ChangeNotifier {

  //razorpay payment
  final _razorpay = Razorpay();
  final ApiService apiService = ApiService();

  String? serviceName;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? address;
  String? phone;
  String? price;
  String?paymentId;
  bool loading = false;

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;

  //initial
  void initial(BuildContext context) {
    void handlePaymentSuccess(PaymentSuccessResponse response) async {

      paymentId = response.paymentId;
      notifyListeners();
    }
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    // _razorpay.on(Razorpay.,handlePaymentSuccess);
  }

  void handlePaymentError(PaymentFailureResponse response) {
  }
  void handleExternalWallet(ExternalWalletResponse response) {

  }

  //order creation
  Future<void> createOrder(
      {required double amount, required BuildContext context}) async {
    try {
      Map<String, dynamic> body = {
        "amount": amount * 100,
        "currency": "INR",
        "receipt": 'idddddd',
      };
      String resId = await apiService.addPayment(
        password: 'Z5bTxTfKBuanTl5FWIuKpFz6',
        userName: 'rzp_test_JFO9OkF4kFeRHA',
        data: body,
      );
      await openGateway(resId);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future openGateway(String id) async {
    var options = {
      'key': 'rzp_test_JFO9OkF4kFeRHA',
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'test',
      'order_id': id,
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {'contact': '923456789', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      },
      "theme": {
        "color": "#11A920",
      },
    };
    _razorpay.open(options);
  }




//date handler
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      notifyListeners();
    }
    notifyListeners();
  }

//time handler
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      _selectedTime = pickedTime;
      notifyListeners();
    }
    notifyListeners();
  }

  //add address handler
  void addAddress({required BuildContext context, required String newAddress}) {
    address = newAddress;
    Navigator.pop(context);
    notifyListeners();
  }

  //phone number handler
  void addPhone({required BuildContext context, required String newPhone}) {
    phone = newPhone;
    Navigator.pop(context);
    notifyListeners();
  }
  void clearData(){
    _selectedDate = null;
    _selectedTime = null;
    address = null;
    phone = null;
    paymentId = null;
    notifyListeners();
  }

  //place booking
  Future<PlaceBookingModel> placeBookingController({
    required BuildContext context,
    required String userId,
    required String userName,
    required String serviceId,
    required String serviceName,
    required String date,
    required String time,
    required String status,
    required String address,
    required String price,
  }) async {

    try {
      loading = true;
      notifyListeners();
      PlaceBookingModel booking = await apiService.placeBooking(
        userId: userId,
        userName: userName,
        serviceId: serviceId,
        serviceName: serviceName,
        date: date,
        time: time,
        status: status,
        address: address,
        price: price,
      );
      Navigator.pushNamed(context, RoutName.successPage);
      loading = false;
      notifyListeners();
      return booking;


    } catch (e) {
      print('Failed to place booking: $e');
      throw e;
    }
  }


}
