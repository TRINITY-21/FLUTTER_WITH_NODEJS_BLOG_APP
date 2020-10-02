import 'dart:convert';

import 'package:NodeWithFlutter/Api/network_handler.dart';
import 'package:NodeWithFlutter/Pages/HomePage.dart';
import 'package:NodeWithFlutter/Pages/SinInPage.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  FlutterSecureStorage storage = FlutterSecureStorage();

  NetworkHandler newtworkHandler = NetworkHandler();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorText;
  bool validate = false;
  bool circular = false;

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
          child: Form(
            key: _globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign up with email",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                usernameTextField(),
                emailTextField(),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      //circular = true;
                    });

                    /// check if user exist
                    await checkUserName();
                    //await checkUserEmail();

                    if (_globalkey.currentState.validate() && validate) {
                      // we will send the data to rest server
                      Map<String, String> dataToSubmit = {
                        "username": _usernameController.text.toLowerCase(),
                        "email": _emailController.text.toLowerCase(),
                        "password": _passwordController.text,
                      };

                      print(dataToSubmit);
                      var response = await newtworkHandler.post(
                          '/api/users/register', dataToSubmit);
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output['success']);
                    
                     if (output["success"]) {
                        await storage.write(
                            key: "token", value: output["user"]["token"]);
                        setState(() {
                          validate = true;
                          circular = true;
                        });

                        print(output["user"]);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                            (route) => false);
                      } else {
                        //String output = json.decode(response.body);
                        setState(() {
                          circular = false;
                        });
                      }
                    }
                  },
                  child: circular
                      ? CircularProgressIndicator()
                      : Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff00A86B),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUserName() async {
    if (_usernameController.text.length == 0) {
      setState(() {
        ///circular = false;
        validate = false;
        errorText = "Username cant be empty";
      });
    } else {
      var res = await newtworkHandler
          .get('/api/users/username/${_usernameController.text}');
      if (res['success']) {
        setState(() {
          //circular = false;
          validate = false;
          errorText = "Username taken";
        });
      } else {
        //circular = false;
        validate = true;
      }
    }
  }

  Widget usernameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Username"),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return "Email can't be empty";
              if (!value.contains("@")) return "Email is Invalid";
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Password"),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password lenght must have >=8";
              return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize: 14,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
