import 'dart:async';
import 'dart:convert';

import 'package:forextainment/bloc/events/AuthenticationEvent.dart';
import 'package:forextainment/bloc/states/AuthenticationState.dart';
import 'package:forextainment/models/User.dart';
import 'package:forextainment/repositories/UserRepository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        String token = await userRepository.getToken();
        User user = await userRepository.getUser();
        yield AuthenticationSuccess(user: user, token: token);
      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await userRepository.persistToken(event.token);
      await userRepository.saveUser(jsonEncode(event.user.toMap()));
      yield AuthenticationSuccess(user: event.user, token: event.token);
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await userRepository.deleteToken();
      yield AuthenticationFailure();
    }
  }
}
