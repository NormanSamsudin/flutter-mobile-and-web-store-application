import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application_store/controllers/subcategory_controller.dart';
import 'package:mobile_application_store/models/category.dart';
import 'package:mobile_application_store/models/subcategory.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/inner_banner_widget.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/inner_category_content_widget.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/inner_header_widget.dart';
import 'package:mobile_application_store/views/screens/detail/screens/widget/subcategory_title_widget.dart';
import 'package:mobile_application_store/views/screens/nav_screens/account_screen.dart';
import 'package:mobile_application_store/views/screens/nav_screens/cart_screen.dart';
import 'package:mobile_application_store/views/screens/nav_screens/category_screen.dart';
import 'package:mobile_application_store/views/screens/nav_screens/favorite_screen.dart';
import 'package:mobile_application_store/views/screens/nav_screens/stores_screen.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/header_widget.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<SubCategory>> _subcategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  int _pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      FavoriteScreen(),
      CategoryScreen(),
      StoresScreen(),
      CartScreen(),
      AccountScreen()
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: InnerHeaderWidget()),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 25,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/love.png',
                width: 25,
              ),
              label: "Favourite"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/mart.png',
                width: 25,
              ),
              label: "Stores"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                width: 25,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                width: 25,
              ),
              label: "Account"),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
