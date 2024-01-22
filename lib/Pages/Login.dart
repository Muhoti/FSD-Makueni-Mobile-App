// ignore_for_file: use_build_context_synchronously, file_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/FootNote.dart';
import 'package:fsd_makueni_mobile_app/Components/ForgetPasswordDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextResponse.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String error = '';
  String email = '';
  String password = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  verifyUser(token) async {
    var token = await storage.read(key: "mljwt");
    var decoded = parseJwt(token.toString());

    if (decoded["error"] == "Invalid token") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(26, 114, 186, 1),
                Color.fromRGBO(49, 161, 254, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200, // Set the desired width
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Data Collection App',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                          child: Column(
                            children: [
                              Form(
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                    const Text(
                                      'Staff Login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextResponse(label: error),
                                    MyTextInput(
                                      title: 'Email Address',
                                      lines: 1,
                                      value: '',
                                      type: TextInputType.emailAddress,
                                      onSubmit: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                    ),
                                    MyTextInput(
                                      title: 'Password',
                                      lines: 1,
                                      value: '',
                                      type: TextInputType.visiblePassword,
                                      onSubmit: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const ForgetPasswordDialog(),
                                        );
                                      },
                                      child: const Text(
                                        'Forgot Password?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SubmitButton(
                                      label: "Submit",
                                      onButtonPressed: () async {
                                        setState(() {
                                          error = "";
                                          isLoading = LoadingAnimationWidget
                                              .horizontalRotatingDots(
                                                  color: Colors.yellow,
                                                  size: 100);
                                        });
                                        var res = await login(email, password);
                                        setState(() {
                                          isLoading = null;
                                          if (res.error == null) {
                                            error = res.success;
                                          } else {
                                            error = res.error;
                                          }
                                        });
                                        if (res.error == null) {
                                          await storage.write(
                                              key: 'mljwt', value: res.token);
                                          verifyUser(res.token);
                                        }
                                      },
                                    ),
                                  ]))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: isLoading,
          )
        ],
      ),
    );
  }
}

Future<Message> login(String email, String password) async {
  if (email.isEmpty || !EmailValidator.validate(email)) {
    return Message(
      token: null,
      success: null,
      error: "Email is invalid!",
    );
  }

  if (password.length < 6) {
    return Message(
      token: null,
      success: null,
      error: "Password is too short!",
    );
  }

  try {
    final response = await http.post(
      Uri.parse("${getUrl()}mobile/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Email': email, 'Password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      return Message(
        token: null,
        success: null,
        error: "Connection to server failed!",
      );
    }
  } catch (e) {
    return Message(
      token: null,
      success: null,
      error: "Connection to server failed!",
    );
  }
}

class Message {
  var token;
  var success;
  var error;

  Message({
    required this.token,
    required this.success,
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      token: json['token'],
      success: json['success'],
      error: json['error'],
    );
  }
}
