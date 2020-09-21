import 'package:teste_gb/model/message.dart';
import 'package:teste_gb/model/user.dart';

class News {
  User user;
  Message message;

  News(
    this.user,
    this.message,
  );

  News.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]),
        message = Message.fromJson(json["message"]);
}
