class UserModel {
  String? email;
  String? phone;
  String? name;
  String? uId;
  String? profileImage;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel(
      {this.email,
      this.phone,
      this.name,
      this.uId,
      this.bio,
      this.cover,
      this.isEmailVerified,
      this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    bio = json['bio'];
    profileImage = json['profileImage'];
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
      'profileImage': profileImage
    };
  }
}
