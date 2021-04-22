import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/bloc/blocs/authentication.bloc.dart';
import 'package:forextainment/bloc/blocs/login.bloc.dart';
import 'package:forextainment/bloc/events/LoginEvent.dart';
import 'package:forextainment/bloc/states/LoginState.dart';
import 'package:forextainment/TermsScreen.dart';
import 'package:forextainment/PrivacyPolicy.dart';

import 'package:forextainment/widgets/AppButtonWidget.dart';
import 'package:forextainment/widgets/ErrorNotification.dart';

final EdgeInsetsGeometry inputPadding = EdgeInsets.only(top: 0, bottom: 0);
final Color purpleColor = const Color(0xff8a56ac);
final InputBorder inputBorder = const UnderlineInputBorder(
  borderSide: BorderSide(
    style: BorderStyle.solid,
    color: Color(0xffdddddd),
  ),
);
final InputBorder focusBorder = const UnderlineInputBorder(
  borderSide: BorderSide(
    style: BorderStyle.solid,
    width: 2,
    color: Color(0xff352641),
  ),
);
final TextStyle hintStyle = const TextStyle(
  color: Color(0x5c241332),
  fontWeight: FontWeight.w500,
  height: 20 / 16,
  letterSpacing: 0.1,
);

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff1f0f2),
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              height: 269,
              width: size.width,
              child: Container(
                height: 269,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height,
              child: Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'FOREX',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'TAINMENT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    LoginTabs(tabController: _tabController),
                    SizedBox(height: 15),
                    Container(
                      width: size.width,
                      height: size.height - 159,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(child: LoginForm()),
                          SingleChildScrollView(child: RegisterForm()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            state is LoginInProgress
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
            state is LoginFailure
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: ErrorNotification(
                      titleText: 'An Error Occurred',
                      bodyText: state.error,
                      okTap: () {
                        BlocProvider.of<LoginBloc>(context).add(ClearFailure());
                      },
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }
}

class LoginTabs extends StatefulWidget {
  const LoginTabs({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  _LoginTabsState createState() => _LoginTabsState();
}

class _LoginTabsState extends State<LoginTabs> {
  final TextStyle tabStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    fontSize: 12,
    height: 26 / 12,
  );
  @override
  void initState() {
    // TODO: implement initState
    widget._tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              widget._tabController.animateTo(0);
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'SIGN IN',
              style: widget._tabController.index == 0
                  ? tabStyle
                  : tabStyle.copyWith(
                      color: Color(0x99ffffff),
                    ),
            ),
          ),
        ),
        SizedBox(
          width: 57,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget._tabController.animateTo(1);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SIGN UP',
              style: widget._tabController.index == 1
                  ? tabStyle
                  : tabStyle.copyWith(color: Color(0x99ffffff)),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  style: hintStyle.copyWith(color: Color(0xff352641)),
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintText: 'Email',
                    hintStyle: hintStyle,
                  ),
                ),
                SizedBox(height: 42),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: hintStyle.copyWith(
                      color: Color(0xff352641), letterSpacing: 4),
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintText: 'Password',
                    hintStyle: hintStyle,
                  ),
                ),
                SizedBox(
                  height: 22,
                )
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          AppButtonWidget(
            onTap: _onLoginButtonPressed,
            text: 'CONTINUE',
            color: Colors.blue,
            height: 52,
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key key,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool termsChecked = false;
  bool policyChecked = false;

  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      if (termsChecked&& policyChecked)
      BlocProvider.of<LoginBloc>(context).add(
        RegisterButtonPressed(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintText: 'First Name',
                    hintStyle: hintStyle,
                  ),
                ),
                SizedBox(height: 42),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintText: 'Last Name',
                    hintStyle: hintStyle,
                  ),
                ),
                SizedBox(height: 42),
                TextField(
                  controller: _emailController,
                  style: hintStyle.copyWith(color: Color(0xff352641)),
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintStyle: hintStyle,
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 42),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintStyle: hintStyle,
                    hintText: 'Phone',
                  ),
                ),
                SizedBox(height: 42),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: inputPadding,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    hintStyle: hintStyle,
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 22),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            child: Row(
              children: [
                Checkbox(
                  value: termsChecked,
                  onChanged: (val) {
                    setState(() {
                      termsChecked = val;
                    });
                  },
                ),
                Text('I agree to the '),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsScreen()),
                    );
                  },
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                Checkbox(
                  value: policyChecked,
                  onChanged: (val) {
                    setState(() {
                      policyChecked = val;
                    });
                  },
                ),
                Text('I agree to the '),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                    );
                  },
                  child: Text(
                    'Privacy policy',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          AppButtonWidget(
            onTap: _onRegisterButtonPressed,
            text: 'CONTINUE',
            color: termsChecked && policyChecked ? Colors.blue : Colors.grey,
            height: 52,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
