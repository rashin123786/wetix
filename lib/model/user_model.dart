class UserModel {
  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? contact;
  String? state;
  String? city;
  String? billing;
  String? status;
  String? role;
  bool? isDelete;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.contact,
    this.state,
    this.city,
    this.billing,
    this.status,
    this.role,
    this.isDelete,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
    contact = json['contact'];
    state = json['state'];
    city = json['city'];
    billing = json['billing'];
    status = json['status'];
    role = json['role'];
    isDelete = json['is_delete'];
    password = json['password'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['email'] = email;
    data['contact'] = contact;
    data['state'] = state;
    data['city'] = city;
    data['billing'] = billing;
    data['status'] = status;
    data['role'] = role;
    data['is_delete'] = isDelete;
    data['password'] = password;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}
