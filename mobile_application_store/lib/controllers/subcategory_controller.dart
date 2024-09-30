import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application_store/global_variables.dart';
import 'package:mobile_application_store/models/subcategory.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  Future<List<SubCategory>> getSubcategoriesByCategoryName(
      String categoryName) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/api/category/$categoryName/subcategories'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=utf-8"
          });

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          List<SubCategory> categories =
              data.map((category) => SubCategory.fromJson(category)).toList();
          return categories;
        } else {
          debugPrint('subcategories not found');
          return [];
        }
      } else if (response.statusCode == 404) {
        debugPrint('subcategories not found');
        return [];
      } else {
        debugPrint('Failed to load subcategories: ');
        return [];
      }
    } catch (e) {
      debugPrint('error $e');
      return [];
    }
  }
}
