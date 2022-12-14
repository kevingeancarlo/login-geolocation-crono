import 'package:animated_login/presentation/widgets/messages_list.dart';
import 'package:flutter/material.dart';

import 'package:animated_login/presentation/widgets/home_page.dart';
import 'package:animated_login/presentation/widgets/date.dart';
import 'package:animated_login/presentation/widgets/login_screen.dart';

import 'dart:async';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  double loadingBallSize = 1;
  AlignmentGeometry _alignment = Alignment.center;
  bool stopScaleAnimtion = false;
  bool showMessages = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        _alignment = Alignment.topRight;
        stopScaleAnimtion = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: 300),
              alignment: _alignment,
              child: TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 500),
                tween: Tween(begin: 0, end: loadingBallSize),
                onEnd: () {
                  if (!stopScaleAnimtion) {
                    setState(() {
                      if (loadingBallSize == 1) {
                        loadingBallSize = 1.5;
                      } else {
                        loadingBallSize = 1;
                      }
                    });
                  } else {
                    Future.delayed(Duration(milliseconds: 300), () {
                      setState(() {
                        showMessages = true;
                      });
                    });
                  }
                },
                builder: (_, value, __) => Transform.scale(
                  scale: value,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: !stopScaleAnimtion
                            ? Colors.black.withOpacity(0.8)
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: stopScaleAnimtion
                          ? TweenAnimationBuilder<double>(
                              duration: Duration(milliseconds: 600),
                              tween: Tween(begin: 0, end: 1),
                              builder: (_, value, __) => Opacity(
                                  opacity: value,
                                  child:
                                      Image.asset("assets/images/avatar.png")))
                          : null),
                ),
              ),
            ),
            if (showMessages) ...[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: Duration(seconds: 1),
                        tween: Tween(begin: 0, end: 1),
                        builder: (_, value, __) => Opacity(
                          opacity: value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hola!",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.85),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Director, a continuaci??n una lista de t??cnicos disponibles",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      MessagesList(),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation_sharp),
      ), */
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            heroTag: null,
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.navigation_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            heroTag: null,
            backgroundColor: Colors.green,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            heroTag: null,
            backgroundColor: Colors.red,
          )
        ]));
  }
}
