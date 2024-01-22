// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextResponse.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  String email = '';
  var isLoading;
  String error = '';
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: const Color.fromRGBO(49, 161, 254, 1),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white)),
              if (error != '') TextResponse(label: error),
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
              SubmitButton(
                label: "Submit",
                onButtonPressed: () async {
                  setState(() {
                    error = "";
                    isLoading = LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.yellow, size: 100);
                  });
                  var res = await recoverPassword(email);
                  setState(() {
                    isLoading = null;
                    if (res.error == null) {
                      error = res.success;
                    } else {
                      error = res.error;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Center(
          child: isLoading,
        )
      ],
    );
  }
}

Future<Message> recoverPassword(String email) async {
  if (email.isEmpty || !EmailValidator.validate(email)) {
    return Message(
      token: null,
      success: null,
      error: "Please Enter Your Email",
    );
  }

  try {
    final response = await http.post(
      Uri.parse("${getUrl()}auth/forgot"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Email': email}),
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
