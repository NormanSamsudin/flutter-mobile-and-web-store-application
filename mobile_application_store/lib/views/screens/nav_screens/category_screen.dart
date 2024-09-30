import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application_store/controllers/category_controller.dart';
import 'package:mobile_application_store/controllers/subcategory_controller.dart';
import 'package:mobile_application_store/models/category.dart';
import 'package:mobile_application_store/models/subcategory.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  List<SubCategory> _subCategory = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
    //once the futurecategories load then
    futureCategories.then((categories){
      _selectedCategory = categories.first;
      _loadSubcategories(_selectedCategory!.name);
    });
  }

  Future<void> _loadSubcategories(String categoryname) async {
    final subcategories = await _subcategoryController
        .getSubcategoriesByCategoryName(categoryname);
    setState(() {
      _subCategory = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: HeaderWidget()),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: FutureBuilder(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No category available'));
                    } else {
                      final categories = snapshot.data!;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = cat;
                                });
                                _loadSubcategories(_selectedCategory!.name);
                              },
                              title: Text(
                                cat.name,
                                style: GoogleFonts.quicksand(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedCategory == cat
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ),
          // Right side display - selected category details
          Expanded(
              flex: 5,
              child: _selectedCategory != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.7),
                          ),
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(_selectedCategory!.banner),
                                  fit: BoxFit.cover)),
                        ),
                        _subCategory.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: _subCategory.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  final subcategory = _subCategory[index];

                                  return Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200),
                                        child: Center(
                                            child: Image.network(
                                          subcategory.image,
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                      Center(
                                        child: Text(
                                          subcategory.subCategoryName,
                                          style: GoogleFonts.quicksand(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                'No sub categories',
                                style: GoogleFonts.quicksand(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ))
                      ],
                    )
                  : Container())
        ],
      ),
    );
  }
}
