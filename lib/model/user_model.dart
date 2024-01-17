class UserModel {
  int? id;
  String? name;
  String? address;
  String? email;
  String? phone;
  String? userName;
  String? password;
  String? role;
  String? city;
  dynamic? photo;
  dynamic? category;
  String? status;
  int? login;

  UserModel(
      {this.id,
        this.name,
        this.address,
        this.email,
        this.phone,
        this.userName,
        this.password,
        this.role,
        this.city,
        this.photo,
        this.category,
        this.status,
        this.login});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    address = json['Address'];
    email = json['Email'];
    phone = json['Phone'];
    userName = json['UserName'];
    password = json['Password'];
    role = json['Role'];
    city = json['City'];
    photo = json['Photo'];
    category = json['Category'];
    status = json['Status'];
    login = json['Login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Role'] = this.role;
    data['City'] = this.city;
    data['Photo'] = this.photo;
    data['Category'] = this.category;
    data['Status'] = this.status;
    data['Login'] = this.login;
    return data;
  }
}