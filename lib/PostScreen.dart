import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forextainment/FullScreenImage.dart';
import 'package:forextainment/bloc/blocs/post.bloc.dart';
import 'package:forextainment/bloc/events/PostEvent.dart';
import 'package:forextainment/bloc/states/PostState.dart';
import 'package:forextainment/models/Category.dart';
import 'package:forextainment/models/Post.dart';

String formatTime(DateTime dateTime) {
  return "${dateTime.hour}: ${dateTime.minute} ";
}

String formatDate(DateTime dateTime) {
  final weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return "${weekdays[dateTime.weekday]} ${dateTime.day} ${months[dateTime.month]} ${dateTime.year}";
}

class PostScreen extends StatefulWidget {
  final Category category;

  PostScreen({this.category});
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isNotEmpty) {
            return ForexPost(
              post: state.posts[0],
            );
          } else {
            return Center(
              child: Text('NO POSTS IN THIS CATEGORY YET'),
            );
          }
        }
        if (state is PostFailure) {
          return PostFailed(message: state.message, category: widget.category);
        }
        return Container();
      },
    );
    // return ForexPost(post: post);
  }
}

class PostFailed extends StatelessWidget {
  const PostFailed({Key key, this.message, this.category}) : super(key: key);
  final String message;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PostBloc>(context).add(PostLoaded(category: category));
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
      ),
    );
  }
}

class ForexPost extends StatelessWidget {
  const ForexPost({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 16),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return FullScreenImage(post.image);
                      },
                    ),
                  );
                },
                child: Image.network(post.image)),
            StatusBar(
              time: formatTime(post.createdAt),
              date: formatDate(post.createdAt),
              status: post.status,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Text(
                    "${post.category} OUTLOOK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(post.outlook),
                      Image.asset(
                        post.outlook == 'BULLISH'
                            ? 'images/bullish.png'
                            : 'images/bearish.png',
//                      width: 200,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  ForexFigures(values: post.values),
                  SizedBox(height: 16),
                  Text(
                    post.body,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'DISCLAMER: We strongly recommend that you risk a maximum of 1 to 2% of your total account size per trade. This signal should not be construed as containing, investment advice, investment research or recommendation. Past performance does not a guarantee future performance. FOREXTAINMENT does not take into account your personal investment objectives or financial situation and assumes no liability as to the accuracy or completeness of the information provided, nor any loss arising from any investment based on a recommendation, forecast or other information supplied by an employee of FOREXTAINMENT, a third party or otherwise. Consequently, any person acting on it does so entirely at their own risk. This material has not been prepared in accordance with legal requirements promoting the independence of investment research and it is not subject to any prohibition on dealing ahead of the dissemination of investment research. All expressions of opinion are subject to change without notice. Any opinions made may be personal to the author and may not reflect the opinions of FOREXTAINMENT. This signal must not be reproduced or further distributed without prior permission. Trading is Risky!',
                    style: TextStyle(fontSize: 11, color: Color(0xff444444)),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForexFigures extends StatelessWidget {
  ForexFigures({@required this.values});
  final List<String> values;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: values.length == 4
          ? Column(
              children: [
                ForexDetailItem(
                  field: 'Entry Price',
                  value: values[0].toString(),
                  icon: Icons.tag,
                  color: Color(0xff0531ff),
                ),
                ForexDetailItem(
                  field: 'Stop Loss Price',
                  value: values[1].toString(),
                  icon: Icons.stop,
                  color: Color(0xffa82e2e),
                ),
//          SizedBox(height: 16),
                ForexDetailItem(
                  icon: Icons.not_interested,
                  field: 'Stop Loss PIPs',
                  value: values[2].toString(),
                  color: Color(0xffa82e2e),
                ),
                ForexDetailItem(
                  color: Color(0xff4bb543),
                  field: 'Take Profit',
                  value: values[3].toString(),
                )
              ],
            )
          : null,
    );
  }
}

class ForexDetailItem extends StatelessWidget {
  ForexDetailItem({
    @required this.field,
    @required this.value,
    this.icon = Icons.trending_down,
    this.color = Colors.greenAccent,
  });
  final String field;
  final String value;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.tag),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), color: color),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    field,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                    color: color, fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: .3,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  StatusBar({@required this.status, @required this.date, @required this.time});
  final String status;
  final String date;
  final String time;
  final Map<String, Color> colors = {
    'pending': Color(0xff606060),
    'success': Color(0xff4BB543),
    'active': Color(0xff0531ff),
    'failed': Color(0xffa82e2e)
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xbb42A5F5),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ForexDetailItem(
            field: 'TIMEFRAME',
            value: 'M30',
            icon: Icons.timer,
            color: Color(0xff0531ff),
          ),
          ForexDetailItem(
            field: date,
            value: time,
            icon: Icons.date_range,
            color: Color(0xff0531ff),
          ),
          ForexDetailItem(
            field: 'Status',
            value: status.toUpperCase(),
            icon: Icons.wb_sunny,
            //TODO: check if status is in array keys of colors
            color: colors[status.toLowerCase()],
          ),
        ],
      ),
    );
  }
}
