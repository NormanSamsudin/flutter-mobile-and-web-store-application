import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_application_store/views/side_bar_screen/buyer_screen.dart';
import 'package:web_application_store/views/side_bar_screen/category_screen.dart';
import 'package:web_application_store/views/side_bar_screen/order_screen.dart';
import 'package:web_application_store/views/side_bar_screen/product_screen.dart';
import 'package:web_application_store/views/side_bar_screen/subcategory_screen.dart';
import 'package:web_application_store/views/side_bar_screen/upload_screen.dart';
import 'package:web_application_store/views/side_bar_screen/vendor_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorScreen();
  String _selectedRoute = VendorScreen.id;

  screenSelector(item) {
    switch (item.route) {
      case VendorScreen.id:
        setState(() {
          _selectedScreen = VendorScreen();
          _selectedRoute = VendorScreen.id;
        });
        break;
      case BuyerScreen.id:
        setState(() {
          _selectedScreen = BuyerScreen();
          _selectedRoute = BuyerScreen.id;
        });
        break;
      case OrderScreen.id:
        setState(() {
          _selectedScreen = OrderScreen();
          _selectedRoute = OrderScreen.id;
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
          _selectedRoute = CategoryScreen.id;
        });
        break;
      case SubcategoryScreen.id:
        setState(() {
          _selectedScreen = SubcategoryScreen();
          _selectedRoute = SubcategoryScreen.id;
        });
        break;
      case UploadScreen.id:
        setState(() {
          _selectedScreen = UploadScreen();
          _selectedRoute = UploadScreen.id;
        });
        break;
      case ProductScreen.id:
        setState(() {
          _selectedScreen = ProductScreen();
          _selectedRoute = ProductScreen.id;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Management'),
      ),
      body: _selectedScreen, // _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: const Center(
            child: Text(
              'Multi Vendor Admin',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                  color: Colors.white),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: 'Vendors',
              route: VendorScreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: 'Buyers',
              route: BuyerScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: 'Orders',
              route: OrderScreen.id,
              icon: CupertinoIcons.cart),
          AdminMenuItem(
              title: 'Categories',
              route: CategoryScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: 'SubCategories',
              route: SubcategoryScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: 'Uoload Banners',
              route: UploadScreen.id,
              icon: Icons.upload),
          AdminMenuItem(
              title: 'Product', route: ProductScreen.id, icon: Icons.store),
        ],
        selectedRoute: _selectedRoute,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
