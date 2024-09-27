import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:web_application_store/global_variable.dart';
import 'package:web_application_store/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:web_application_store/services/manage_http_response.dart';

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("devuu2aov", "jyqzc4qz");

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedBanner', folder: 'banners'));

      String image = bannerResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(Uri.parse("$uri/api/banner"),
          body: bannerModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Banner Uploaded');
          });
    } catch (e) {
      print("Error uploading to cloudinary $e");
    }
  }

  // fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/banner'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=utf-8"
          });

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      }
      throw Exception('Failed to load banner');
    } catch (e) {
      debugPrint('error $e');
      throw Exception('Error loading banner $e');
    }
  }
}
