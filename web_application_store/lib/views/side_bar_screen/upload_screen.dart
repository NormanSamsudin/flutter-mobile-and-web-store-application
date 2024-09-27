import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_application_store/controllers/banner_controller.dart';
import 'package:web_application_store/views/side_bar_screen/widgets/banner_widget.dart';

class UploadScreen extends StatefulWidget {
  static const String id = '\\upload-screen';

  UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
 
  final BannerController _bannerController = new BannerController();
  dynamic _image;
  late String categoryName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft, child: Text('UploadScreen')),
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              child: Center(
                  child: _image != null
                      ? Image.memory(_image)
                      : Text('Category Image')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await _bannerController.uploadBanner(
                        pickedImage: _image, context: context);
                  },
                  child: Text('save')),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Pick Image')),
        ),
        Divider(color: Colors.grey,),
        BannerWidget(),
      ],
    );
  }
}
