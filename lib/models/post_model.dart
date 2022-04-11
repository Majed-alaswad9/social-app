class PostModel {
  String? name;
  String? uId;
  String? dateTime;
  String? text;
  String? image;


  PostModel(
      {
        this.name,
        this.uId,
        this.text,
        this.dateTime,
        this.image
});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    text=json['text'];
    dateTime=json['dateTime'];
    image=json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'text':text,
      'dateTime':dateTime,
      'image':image
    };
  }
}
