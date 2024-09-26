import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_application_store/global_variable.dart';
import 'package:web_application_store/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:web_application_store/services/manage_http_response.dart';

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickedBanner,
      required String name,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("devuu2aov", "jyqzc4qz");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImage'));

      String image = imageResponse.secureUrl;
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedBanner,
              identifier: 'pickedBanner', folder: 'bannerImage'));

      String banner = bannerResponse.secureUrl;

      Category category =
          Category(id: '', name: name, image: image, banner: banner);

      http.Response response = await http.post(Uri.parse("$uri/api/categories"),
          body: category.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded categopry');
          });
    } catch (e) {
      print("Error uploading to cloudinary $e");
    }
  }
}
