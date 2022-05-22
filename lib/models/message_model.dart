class MessageModel {
  String? sendId;
  String? receiveId;
  String? dateTime;
  String? text;

  MessageModel(
      {this.sendId,
        this.receiveId,
        this.dateTime,
        this.text,});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sendId = json['sendId'];
    receiveId = json['receiveId'];
    dateTime = json['dateTime'];
    text = json['text'];

  }

  Map<String, dynamic> toMap() {
    return {
      'sendId': sendId,
      'receiveId': receiveId,
      'dateTime': dateTime,
      'text': text,

    };
  }
}