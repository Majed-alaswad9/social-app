class UserCreate {
  String? email;
  String? phone;
  String? name;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserCreate(
      {this.email,
      this.phone,
      this.name,
      this.uId,
      this.bio,
      this.cover,
      this.isEmailVerified,
      this.image});

  UserCreate.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    bio = json['bio'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'image': image
    };
  }
}
