import 'dart:convert';

import 'package:NodeWithFlutter/Pages/googleFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;

import 'SinInPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController _controller1;
  Animation<Offset> animation1;
  AnimationController _controller2;
  Animation<Offset> animation2;
  bool _isLogin = false;
  Map data;
  final facebookLogin = FacebookLogin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //animation 1
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeOut),
    );

// animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut),
    );

    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green[200]],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                SlideTransition(
                  position: animation1,
                  child: Text(
                    "DevStack",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                SlideTransition(
                  position: animation1,
                  child: Text(
                    "Great stories for great people",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                boxContainer("assets/google.png", "Sign up with Google", null),
                SizedBox(
                  height: 10,
                ),
                boxContainer(
                    "assets/facebook1.png", "Sign up with Facebook", onFBLogin),
                SizedBox(
                  height: 10,
                ),
                boxContainer(
                  "assets/email2.png",
                  "Sign up with Email",
                  onEmailClick,
                ),
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: animation2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onFBLogin() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken;
        final res = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
        final userData = json.decode(res.body);
        print('userdata$data');
        setState(() {
          _isLogin = true;
          data = userData;
        });

        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLogin = false;
        });

        break;

      case FacebookLoginStatus.error:
        setState(() {
          _isLogin = false;
        });

        break;

      default:
    }
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
