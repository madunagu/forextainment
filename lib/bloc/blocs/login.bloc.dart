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

        authenticationBloc.add(
          AuthenticationLoggedIn(token: data.token, user: data.user),
        );
        yield LoginInitial();
      } on ServerErrorException catch (error) {
        yield LoginFailure(
          error: 'Unable to Register Contact Administrator',
        );
      } catch (error) {
        log(error.toString());
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoginInProgress();
      try {
        final LoginData data = await userRepository.register(
          username: event.phone,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          phone: event.phone,
          password: event.password,
        );

        log(data.toString());

        authenticationBloc.add(
          AuthenticationLoggedIn(
            token: 'loggedin',
            user: User(
              email: event.email,
              firstName: event.firstName,
              lastName: event.lastName,
              phone: event.phone,
            ),
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
