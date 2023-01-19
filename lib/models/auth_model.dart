class AuthModel {
  String? id;
  String? username;
  String? token;
  String? avatar;
  String? active;

  AuthModel({this.id, this.username, this.token, this.avatar, this.active});

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
    avatar = json['avatar'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    return data;
  }
}
