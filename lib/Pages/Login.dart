import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/ForgetPasswordDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextLarge.dart';
import 'package:fsd_makueni_mobile_app/Components/TextMedium.dart';
import 'package:fsd_makueni_mobile_app/Components/TextResponse.dart';
import 'package:fsd_makueni_mobile_app/Components/TextSmall.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Pages/Register.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        
        primaryColor: const Color(
            0xFFFF6200), // Define the accent color for buttons, etc.
        scaffoldBackgroundColor: Colors.white, // Set the scaffold background color to orange
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0x00fda766)),
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Center(
                child: Container(
                    constraints: const BoxConstraints.tightForFinite(),
                    child: SingleChildScrollView(
                      child: Form(
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(84, 24, 84, 12),
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            const TextLarge(label: "Login"),
                            TextResponse(label: error),
                            MyTextInput(
                              title: 'Email',
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
                                // Show the ForgetPasswordDialog when the "Forget Password" link is clicked.
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const ForgetPasswordDialog(),
                                );
                              },
                              child: const TextSmall(
                                label: 'Forgot Password?',
                              ),
                            ),
                            SubmitButton(
                              label: "Login",
                              onButtonPressed: () async {
                                setState(() {
                                  isLoading =
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Color.fromRGBO(0, 128, 0, 1),
                                    size: 100,
                                  );
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
                                      key: 'erjwt', value: res.token);
                                  // PROCEED TO NEXT PAGE
                                }
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                // Show the ForgetPasswordDialog when the "Forget Password" link is clicked.
                                showDialog(
                                  context: context,
                                  builder: (context) => const Register(),
                                );
                              },
                              child: const TextMedium(
                                label: 'REGISTER',
                              ),
                            ),
                          ]))),
                    )),
              )
            ],
          )),
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
