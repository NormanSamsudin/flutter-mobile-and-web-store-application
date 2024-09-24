import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['error']);
      break; 
    case 201:
      onSuccess();
      break;
    default:
      showSnackBar(context, json.decode(response.body)['error']);
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
