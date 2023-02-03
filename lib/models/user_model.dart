class UserModel {
  String? id;
  String? username;
  String? avatar;
  String? created;
  String? description;
  String? link;
  String? address;
  String? city;
  String? country;
  String? listing;
  String? isFriend;
  String? sameFriends;

  String? online;

  UserModel(
      {this.id,
      this.username,
      this.avatar,
      this.created,
      this.description,
      this.link,
      this.address,
      this.city,
      this.country,
      this.listing,
      this.isFriend,
      this.sameFriends,
      this.online});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['user_id'];
    username = json['username'] ?? 'Người dùng';
    avatar = json['avatar'];
    created = json['created'];
    description = json['description'];
    link = json['link'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    listing = json['listing'];
    isFriend = json['is_friend'];
    sameFriends = json['same_friends'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username ?? 'Người dùng';
    data['avatar'] = this.avatar;
    data['created'] = this.created;
    data['description'] = this.description;
    data['link'] = this.link;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['listing'] = this.listing;
    data['is_friend'] = this.isFriend;
    data['same_friends'] = this.sameFriends;
    data['online'] = this.online;
    return data;
  }
}
