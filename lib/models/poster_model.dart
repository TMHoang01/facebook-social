class PosterModel {
  String? id;
  String? username;
  String? avatar;

  PosterModel({this.id, this.username, this.avatar});

  PosterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'] ?? json['name'] ?? "Người dùng Facebook";
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}
