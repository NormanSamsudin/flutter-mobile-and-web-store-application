import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_application_store/models/user.dart';
import 'package:mobile_application_store/global_variables.dart';
import 'package:mobile_application_store/provider/user_provider.dart';
import 'package:mobile_application_store/services/manage_http_responses.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application_store/views/screens/authentication/login_screen.dart';
import 'package:mobile_application_store/views/screens/main_screen.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
            showSnackBar(context, 'Account has been created for you');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            //access sharedPreferences for token and user data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            //Extract the authentication token from response body
            String token = jsonDecode(response.body)['token'];

            //mobile_application_store the token in shared preferences
            await preferences.setString('auth_token', token);

            //Encode the user data recieved from the server as json
            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            // update the application state with the user data via riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);

            // mobile_application_store data in sharedPreference for future use
            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MainScreen();
            }), (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  //Signout
  Future<void> signOutUsers({required context}) async {
    try {
      // access sharedPreferences for token and user data storage
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // remove the token from shared preferences
      await preferences.remove('auth_token');
      await preferences.remove('user');

      // clear user state
      providerContainer.read(userProvider.notifier).signOut();

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'Logged Out successfully');
    } catch (exception) {
      showSnackBar(context, 'error logging out');
    }
  }
}
