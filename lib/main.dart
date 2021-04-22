import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/ChartScreen.dart';
import 'package:forextainment/LoginScreen.dart';
import 'package:forextainment/NetworkingClass.dart';
import 'package:forextainment/SplashScreen.dart';
import 'package:forextainment/TermsScreen.dart';
import 'package:forextainment/ProfileScreen.dart';
import 'package:forextainment/bloc/blocs/authentication.bloc.dart';
import 'package:forextainment/bloc/blocs/category.bloc.dart';
import 'package:forextainment/bloc/blocs/post.bloc.dart';
import 'package:forextainment/bloc/blocs/login.bloc.dart';
import 'package:forextainment/bloc/events/AuthenticationEvent.dart';
import 'package:forextainment/bloc/states/AuthenticationState.dart';
import 'package:forextainment/bloc/states/category_state.dart';
import 'package:forextainment/bloc/events/category_event.dart';
import 'package:forextainment/models/Category.dart';
import 'package:forextainment/repositories/UserRepository.dart';
import 'package:forextainment/models/Post.dart';
import 'package:forextainment/widgets/LoadingIndicator.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationStarted()),
        ),
        BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc()..add(CategoryLoaded())),
        BlocProvider<PostBloc>(create: (context) => PostBloc()),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: UserRepository(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//LwGI}ji9ye%(
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashScreen();
          }
          if (state is AuthenticationSuccess) {
            return MainScreen(authState: state);
          }
          if (state is AuthenticationFailure) {
            return LoginScreen();
          }
          if (state is AuthenticationInProgress) {
            return LoadingIndicator();
          }
          return Container();
        },
      ),
      title: 'Forextainment',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

var appTheme = ThemeData(
  fontFamily: 'Montserrat',
  // primaryColor: Color(0xff8a56ac),
  // accentColor: Color(0xffd47fa6),
);

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({@required this.authState});
  final AuthenticationSuccess authState;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return ForexLoadingScreen();
        }
        if (state is CategorySuccess) {
          return ForexLoadedScreen(
            categories: state.categories,
            state: widget.authState,
          );
        }
        if (state is CategoryFailure) {
          return ForexFailedScreen(message: state.message);
        }
        return Container();
      },
    );
  }
}

class ForexLoadingScreen extends StatelessWidget {
  const ForexLoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        // leadingWidth: 100,
        title: TitleBar(),
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'FOREX',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0531ff),
          ),
        ),
        Text(
          'TAINMENT',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xffff4d00),
          ),
        )
      ],
    );
  }
}

class ForexFailedScreen extends StatelessWidget {
  const ForexFailedScreen({Key key, this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              BlocProvider.of<CategoryBloc>(context).add(CategoryLoaded());
              log('trying again.....');
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Tap the icon to try again ...',
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  Icon(
                    Icons.refresh,
                    size: 26,
                    color: Colors.grey,
                  ),
                ],
              ),
            )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        // leadingWidth: 100,
        title: TitleBar(),
      ),
    );
  }
}

class ForexLoadedScreen extends StatefulWidget {
  ForexLoadedScreen({Key key, @required this.categories, @required this.state})
      : super(key: key);
  final List<Category> categories;
  final AuthenticationState state;
  @override
  _ForexLoadedScreenState createState() => _ForexLoadedScreenState();
}

class _ForexLoadedScreenState extends State<ForexLoadedScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    this._tabController = TabController(
        vsync: this, length: widget.categories.length, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          controller: _tabController,
          children: widget.categories
              .map((Category category) => ChartScreen(category: category))
              .toList(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        // leadingWidth: 100,
        elevation: 0,

        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(state: widget.state)),
                ),
                child: Icon(
                  Icons.person,
                  size: 26.0,
                  color: Colors.black,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationLoggedOut(),
                ),
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                  color: Colors.black,
                ),
              )),
        ],
        title: TitleBar(),
        bottom: TabBar(
//          labelPadding: EdgeInsets.only(
//            top: 16,
//            left: 16,
//            right: 16,
//          ),
          labelColor: Color(0xff0531ff),
          isScrollable: true,
          labelStyle: TextStyle(
            color: Colors.blue,
            fontFamily: 'Montserrat',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Color(0xffff4d00),
          unselectedLabelStyle: TextStyle(
            color: Colors.orange,
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onTap: (i) {
            _tabController.index = i;
          },
          indicator: BoxDecoration(),
          controller: _tabController,
          tabs: widget.categories
              .map((Category e) => Tab(
                    text: e.name,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
