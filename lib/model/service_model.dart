

class ServiceModel {
  int? id;
  String? serviceName;
  String? serviceImage;
  String? price;
  String? description;
  int? categoryId;

  ServiceModel(
      {this.id,
        this.serviceName,
        this.serviceImage,
        this.price,
        this.description,
        this.categoryId});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['ServiceName'];
    serviceImage = json['ServiceImage'];
    price = json['Price'];
    description = json['Description'];
    categoryId = json['CategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ServiceName'] = this.serviceName;
    data['ServiceImage'] = this.serviceImage;
    data['Price'] = this.price;
    data['Description'] = this.description;
    data['CategoryId'] = this.categoryId;
    return data;
  }
}