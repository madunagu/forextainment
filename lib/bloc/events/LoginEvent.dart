import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class ClearFailure extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RegisterButtonPressed extends LoginEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  const RegisterButtonPressed({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.password,
  });

  @override
  List<Object> get props => [firstName,lastName, email, phone];

  @override
  String toString() =>
      'LoginButtonPressed { name: $firstName $lastName, email: $email, phone: $phone }';
}
