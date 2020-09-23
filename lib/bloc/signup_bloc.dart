import 'package:rxdart/rxdart.dart';
import 'package:teste_gb/bloc/authorization_bloc.dart';
import 'package:teste_gb/services/login/login_repository.dart';
import 'package:teste_gb/validator/validators.dart';

class SignupBloc extends Validators {
  AuthRepository repository = AuthRepository();

  final BehaviorSubject _nameController = BehaviorSubject<String>();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get name => _nameController.stream.transform(validateName);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

  Stream<bool> get loading => _loadingData.stream;

  void submit() {
    final validName = _nameController.value;
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    signup(validName, validEmail, validPassword);
  }

  signup(String name, String email, String password) async {
    String token = await repository.signup(name, email, password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
