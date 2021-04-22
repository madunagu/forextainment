import 'package:flutter/material.dart';
import 'package:forextainment/bloc/states/AuthenticationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/bloc/blocs/authentication.bloc.dart';
import 'package:forextainment/bloc/events/AuthenticationEvent.dart';
import 'package:forextainment/main.dart';
//dont let me move without you lord oh my God o my God take it away

class ProfileScreen extends StatelessWidget {
  ProfileScreen({@required this.state});
  final AuthenticationSuccess state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: TitleBar(),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(authState: state)),
                ),
                child: Icon(
                  Icons.home,
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
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                   "${state.user.firstName} ${state.user.lastName}",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      state.user.email,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Phone',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      state.user.phone,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
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
