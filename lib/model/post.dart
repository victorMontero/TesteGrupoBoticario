import 'package:teste_gb/model/message.dart';
import 'package:teste_gb/model/user.dart';

class Post {
  User user;
  Message message;

  Post(this.user,
      this.message,);
}