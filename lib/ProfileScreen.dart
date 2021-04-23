import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:forextainment/bloc/states/AuthenticationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/bloc/blocs/authentication.bloc.dart';
import 'package:forextainment/bloc/events/AuthenticationEvent.dart';
import 'package:forextainment/main.dart';
import 'package:forextainment/widgets/TitleBar.dart';
//dont let me move without you lord oh my God o my God take it away

class ProfileScreen extends StatelessWidget {
  ProfileScreen({@required this.state});
  final AuthenticationSuccess state;

  String imageUrl(String email) {
    final gravatar = Gravatar(email);
    gravatar.imageUrl();
    gravatar.profileUrl();
    return gravatar.hash();
  }

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
            padding: EdgeInsets.only(right: 32.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(authState: state),
                ),
              ),
              child: Icon(
                Icons.home,
                size: 20.0,
                color: Color(0xffff4d00),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoggedOut(),
              ),
              child: Icon(
                Icons.logout,
                size: 20.0,
                color: Color(0xffff4d00),
              ),
            ),
          ),
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
                            "https://www.gravatar.com/avatar/"+imageUrl(state.user.email),
                          ),
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
