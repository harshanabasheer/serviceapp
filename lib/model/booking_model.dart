class BookingModel {
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
  String? serviceImage;

  BookingModel(
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
        this.price,
        this.serviceImage});

  BookingModel.fromJson(Map<String, dynamic> json) {
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
    serviceImage = json['ServiceImage'];
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
    data['ServiceImage'] = this.serviceImage;
    return data;
  }
}