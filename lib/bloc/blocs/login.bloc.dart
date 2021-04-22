import 'dart:async';
import 'dart:developer';

import 'package:forextainment/NetworkingClass.dart';
import 'package:forextainment/Exceptions.dart';
import 'package:forextainment/bloc/blocs/authentication.bloc.dart';
import 'package:forextainment/bloc/events/AuthenticationEvent.dart';
import 'package:forextainment/bloc/events/LoginEvent.dart';
import 'package:forextainment/bloc/states/LoginState.dart';
import 'package:forextainment/models/LoginData.dart';
import 'package:forextainment/models/User.dart';
import 'package:forextainment/repositories/UserRepository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final LoginData data = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc
            .add(AuthenticationLoggedIn(token: data.token, user: data.user));
        yield LoginInitial();
      } on ServerErrorException catch (error) {
        yield LoginFailure(
          error:
              'Unable to Log In, may be due to Incorrect Username and Password',
        );
      } catch (error) {
        log(error.toString());
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoginInProgress();
      try {
        Map<String, dynamic> res =
            await NetworkingClass().post('/users/register', {
          'username': event.phone,
          'first_name': event.firstName,
          'last_name': event.lastName,
          'email': event.email,
          'password': event.password,
        });
        log(res.toString());

        authenticationBloc.add(
          AuthenticationLoggedIn(
            token: 'loggedin',
            user: User(
                email: event.email,
                firstName: event.firstName,
                lastName: event.lastName,
                phone: event.phone),
          ),
        );
        yield LoginInitial();
      } catch (error) {
        log(error.toString());
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is ClearFailure) {
      yield LoginInitial();
    }
  }
}
