import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/PostScreen.dart';
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
import 'package:forextainment/bloc/events/PostEvent.dart';
import 'package:forextainment/bloc/states/AuthenticationState.dart';
import 'package:forextainment/bloc/states/category_state.dart';
import 'package:forextainment/bloc/events/category_event.dart';
import 'package:forextainment/models/Category.dart';
import 'package:forextainment/repositories/UserRepository.dart';
import 'package:forextainment/models/Post.dart';
import 'package:forextainment/widgets/LoadingIndicator.dart';
import 'package:forextainment/widgets/TitleBar.dart';

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

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    this._tabController = TabController(
      vsync: this,
      length: 0,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget switchBody(CategoryState state) {
    if (state is CategoryLoading) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (state is CategoryFailure) {
      return Container(
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
                  state.message,
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
          ),
        ),
      );
    }

    if (state is CategorySuccess) {
      refreshTabs(state);
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          controller: _tabController,
          children: state.categories
              .map(
                (Category category) => BlocProvider<PostBloc>(
                  create: (context) =>
                      PostBloc()..add(PostLoaded(category: category)),
                  child: PostScreen(
                    category: category,
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void refreshTabs(CategorySuccess state) {
    this._tabController = TabController(
        length: state.categories.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          body: switchBody(state),
          appBar: AppBar(
            elevation: 0,
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 32.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(state: widget.authState),
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 20.0,
                    color: Color(0xffff4d00),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {

                    });
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationLoggedOut(),
                    );
                    setState(() {});
                  },
                  child: Icon(
                    Icons.logout,
                    size: 20.0,
                    color: Color(0xffff4d00),
                  ),
                ),
              ),
            ],
            bottom: state is CategorySuccess
                ? TabBar(
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
                    tabs: state.categories
                        .map((Category e) => Tab(
                              text: e.name,
                            ))
                        .toList(),
                  )
                : null,
          ),
        );
      },
    );
  }
}
