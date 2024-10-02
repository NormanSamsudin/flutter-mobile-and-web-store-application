import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application_store/controllers/subcategory_controller.dart';
import 'package:mobile_application_store/models/category.dart';
import 'package:mobile_application_store/models/subcategory.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/inner_banner_widget.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/inner_header_widget.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/subcategory_title_widget.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/header_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> _subcategories;
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize:
        //         Size.fromHeight(MediaQuery.of(context).size.height * 20),
        //     child: InnerHeaderWidget()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InnerBannerWidget(image: widget.category.banner),
              Center(
                child: Text(
                  'Shop By Categories',
                  style: GoogleFonts.quicksand(),
                ),
              ),
              FutureBuilder(
                  future: _subcategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No subcategory available'));
                    } else {
                      final subcategories = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: List.generate(
                              (subcategories.length / 7).ceil(), (setIndex) {
                            final start = setIndex * 7;
                            final end = (setIndex + 1) * 7;

                            return Padding(
                              padding: EdgeInsets.all(9),
                              child: Row(
                                children: subcategories
                                    .sublist(
                                        start.toInt(),
                                        end > subcategories.length
                                            ? subcategories.length
                                            : end)
                                    .map((subcategory) =>
                                        SubcategoryTitleWidget(
                                          image: subcategory.image,
                                          title: subcategory.subCategoryName,
                                        ))
                                    .toList(),
                              ),
                            );
                          }),
                        ),
                      );

                      // GridView.builder(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: subcategories.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 4,
                      //             crossAxisSpacing: 8,
                      //             mainAxisSpacing: 8),
                      //     itemBuilder: (context, index) {
                      //       final cat = subcategories[index];
                      //       return SubcategoryTitleWidget(
                      //           image: cat.image, title: cat.subCategoryName);
                      //     });
                    }
                  }),
            ],
          ),
        ));
  }
}
