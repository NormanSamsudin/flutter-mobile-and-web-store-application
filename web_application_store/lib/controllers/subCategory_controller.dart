import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:web_application_store/global_variable.dart';
import 'package:web_application_store/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:web_application_store/services/manage_http_response.dart';

class SubcategoryController {

  uploadSubCategory(
      {required String categoryId,
      required String categoryName,
      required dynamic pickedImage,
      required String subCategoryName,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("devuu2aov", "jyqzc4qz");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImage'));

      String imageUrl = imageResponse.secureUrl;

      SubCategoryModel category = SubCategoryModel(
          categoryId: categoryId,
          categoryName: categoryName,
          image: imageUrl,
          id: '',
          subCategoryName: subCategoryName);

      http.Response response = await http.post(Uri.parse("$uri/api/subcategories"),
          body: category.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded subcategory');
          });
    } catch (e) {
      print("Error uploading to cloudinary $e");
    }
  }

  //fetch subcategory
    Future<List<SubCategoryModel>> loadCategories() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/subcategories'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=utf-8"
          });

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<SubCategoryModel> categories =
            data.map((category) => SubCategoryModel.fromJson(category)).toList();
        return categories;
      }
      throw Exception('Failed to load categories');
    } catch (e) {
      debugPrint('error $e');
      throw Exception('Error loading categories $e');
    }
  }
}
