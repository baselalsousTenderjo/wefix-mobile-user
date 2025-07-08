class ChatsModel {
  List<Chats>? chats;

  ChatsModel({
    this.chats,
  });

  ChatsModel.fromJson(Map<String, dynamic> json) {
    chats = (json['chats'] as List?)
        ?.map((dynamic e) => Chats.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['chats'] = chats?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Chats {
  int? id;
  String? message;
  String? image;
  String? createdDate;
  int? fromUserId;
  int? toUserId;
  String? fromUserName;
  dynamic imageUser;

  Chats({
    this.id,
    this.message,
    this.image,
    this.createdDate,
    this.fromUserId,
    this.toUserId,
    this.fromUserName,
    this.imageUser,
  });

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    message = json['message'] as String?;
    image = json['image'] as String?;
    createdDate = json['createdDate'] as String?;
    fromUserId = json['fromUserId'] as int?;
    toUserId = json['toUserId'] as int?;
    fromUserName = json['fromUserName'] as String?;
    imageUser = json['imageUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['message'] = message;
    json['image'] = image;
    json['createdDate'] = createdDate;
    json['fromUserId'] = fromUserId;
    json['toUserId'] = toUserId;
    json['fromUserName'] = fromUserName;
    json['imageUser'] = imageUser;
    return json;
  }
}
