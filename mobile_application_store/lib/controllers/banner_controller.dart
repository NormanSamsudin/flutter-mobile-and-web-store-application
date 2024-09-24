import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application_store/models/banner_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application_store/global_variables.dart';

class BannerController {
  // fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http
          .get(Uri.parse("$uri/api/banner"), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      });

      debugPrint(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Error load Banners');
    }
  }
}
