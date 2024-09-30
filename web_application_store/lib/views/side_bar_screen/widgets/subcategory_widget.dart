import 'package:flutter/material.dart';
import 'package:web_application_store/controllers/category_controller.dart';
import 'package:web_application_store/controllers/subCategory_controller.dart';
import 'package:web_application_store/models/category.dart';
import 'package:web_application_store/models/subcategory.dart';

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({super.key});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  late Future<List<SubCategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = SubcategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No category available'));
          } else {
            final categories = snapshot.data!;
            return GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Column(
                    children: [
                      Image.network(
                        cat.image,
                        height: 100,
                        width: 100,
                      ),
                      Text(cat.categoryName),
                    ],
                  );
                });
          }
        });
  }
}
