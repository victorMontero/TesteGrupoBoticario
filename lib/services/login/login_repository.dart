
import 'package:teste_gb/services/login/login_provider.dart';

class AuthRepository {

  final AuthProvider authProvider = AuthProvider();
  Future<String> login(String email, String password) => authProvider.login(email: email, password: password);
  Future<String> signup(String name, String email, String password) => authProvider.signup(email: email, password: password);

}