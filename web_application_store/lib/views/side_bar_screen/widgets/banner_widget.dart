// import 'package:flutter/material.dart';
// import 'package:web_application_store/controllers/banner_controller.dart';
// import 'package:web_application_store/models/banner.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

// class BannerWidget extends StatefulWidget {
//   const BannerWidget({super.key});

//   @override
//   State<BannerWidget> createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   late Future<List<BannerModel>> futureBanners;
//   late WebSocketChannel channel;
//   List<BannerModel> banners = [];

//   void setSocket() async {
//     channel = WebSocketChannel.connect(
//       Uri.parse('ws://127.0.0.1:3000/api/banner'), // Use your backend's URL
//     );

//     await channel.ready;
//   }

//   @override
//   void initState() {
//     super.initState();
//     futureBanners = BannerController().loadBanners();
//     setSocket();

//     // Load initial data
//     futureBanners.then((loadedBanners) {
//       setState(() {
//         banners = loadedBanners;
//       });
//     });

//     // Listen for new banners from WebSocket
//     channel.stream.listen((message) {
//       setState(() {
//         banners.add(BannerModel.fromJson(message)); // Parse new banner data
//       });
//     });
//   }

//   @override
//   void dispose() {
//     channel.sink.close(status.goingAway);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemCount: banners.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 6,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemBuilder: (context, index) {
//         final banner = banners[index];
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Card(
//             child: Image.network(
//               banner.image,
//               height: 100,
//               width: 100,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:web_application_store/controllers/banner_controller.dart';
import 'package:web_application_store/models/banner.dart';

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
    return FutureBuilder(
        future: futureBanners,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No banners available'));
          } else {
            final banners = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: banners.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Image.network(
                        banner.image,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  );
                });
          }
        });
  }
}
