import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetix/model/user_model.dart';
import 'package:wetix/utils/url.dart';
import 'package:wetix/view/Authentication/Login/login_screen.dart';
import 'package:wetix/view/widgets/bottom_nav.dart';

import '../../utils/constants/constants.dart';

class AutherServices {
  // SIGNUP

  void signUp(context, String fullName, String userName, String email,
      String password) async {
    final headers = {
      "Content-type": "application/json",
    };
    final body = jsonEncode({
      "fullName": fullName,
      "userName": userName,
      "email": email,
      "password": password,
    });
    final responses =
        await http.post(Uri.parse(signUpUri), body: body, headers: headers);
    log(responses.body);
    if (responses.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Success!.Now please Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
      final result = jsonDecode(responses.body);
      final userData = result['user'];
      userModel = UserModel.fromJson(userData);
      log(userModel!.id ?? 'not get');
      specificUserId = userModel!.id;
      log("this is spec-ific --------------$specificUserId");

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else if (responses.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Username is already taken",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Signup failed,please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // LOGIN

  void loginServices(context, String userName, String password) async {
    final headers = {
      "Content-type": "application/json",
    };
    final body = jsonEncode({
      "userName": userName,
      "password": password,
    });
    log('enetred');
    try {
      final response =
          await http.post(Uri.parse(loginUri), body: body, headers: headers);
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
        log(response.body);
        final result = await jsonDecode(response.body);
        token = result['token'];
        specificUserId = result['id'];
        log(specificUserId.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token!);
        log(token ?? '');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavWidget(),
            ));
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Please provide username and password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Invalid password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Login failed,please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      log("exception errpr$e");
    }
  }
}
