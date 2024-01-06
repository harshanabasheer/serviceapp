class PlaceBookingModel {
  Data? data;
  String? message;
  bool? success;

  PlaceBookingModel({this.data, this.message, this.success});

  PlaceBookingModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? userName;
  String? serviceId;
  String? serviceName;
  Null? workerId;
  Null? workerName;
  String? date;
  String? time;
  String? status;
  String? address;
  String? price;

  Data(
      {this.id,
        this.userId,
        this.userName,
        this.serviceId,
        this.serviceName,
        this.workerId,
        this.workerName,
        this.date,
        this.time,
        this.status,
        this.address,
        this.price});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    userName = json['UserName'];
    serviceId = json['ServiceId'];
    serviceName = json['ServiceName'];
    workerId = json['WorkerId'];
    workerName = json['WorkerName'];
    date = json['Date'];
    time = json['Time'];
    status = json['Status'];
    address = json['Address'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['ServiceId'] = this.serviceId;
    data['ServiceName'] = this.serviceName;
    data['WorkerId'] = this.workerId;
    data['WorkerName'] = this.workerName;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Status'] = this.status;
    data['Address'] = this.address;
    data['Price'] = this.price;
    return data;
  }
}