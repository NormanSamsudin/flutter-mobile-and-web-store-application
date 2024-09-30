import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application_store/controllers/category_controller.dart';
import 'package:mobile_application_store/models/category.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/reuseable_text_widget.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
     
      children: [
        const ReuseableTextWidget(title: 'Categories', subtitle: 'View all',),
        FutureBuilder(
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
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Column(
                        children: [
                          Image.network(
                            cat.image,
                            height: 47,
                            width: 47,
                          ),
                          Text(cat.name, style: GoogleFonts.quicksand( fontWeight: FontWeight.bold, fontSize: 15),),
                        ],
                      );
                    });
              }
            }),
      ],
    );
  }
}
