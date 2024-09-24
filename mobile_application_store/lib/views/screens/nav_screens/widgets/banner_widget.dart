import 'package:flutter/material.dart';
import 'package:mobile_application_store/controllers/banner_controller.dart';
import 'package:mobile_application_store/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 241, 241),
          borderRadius: BorderRadius.circular(4)),
      child: FutureBuilder(
          future: futureBanners,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Banners'),
              );
            } else {
              final banner = snapshot.data!;
              return PageView.builder(
                itemCount: banner.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      banner[index].image,
                      height: 100,
                      width: 100,
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
