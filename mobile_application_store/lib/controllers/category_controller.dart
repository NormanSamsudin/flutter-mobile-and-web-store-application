import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application_store/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application_store/global_variables.dart';

class BannerController {
  // fetch banner
  Future<List<Category>> loadBanners() async {
    try {
      http.Response response = await http
          .get(Uri.parse("$uri/api/banner"), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      });

      debugPrint(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((banner) => Category.fromJson(banner)).toList();
        return categories;
      } else {
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Error load Banners');
    }
  }
}
