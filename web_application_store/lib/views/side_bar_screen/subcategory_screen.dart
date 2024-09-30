import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_application_store/controllers/category_controller.dart';
import 'package:web_application_store/controllers/subCategory_controller.dart';
import 'package:web_application_store/models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = '\\subCategory-screen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<List<CategoryModel>> futureCategories;
  CategoryModel? selectedCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SubcategoryController _subCategoryController = SubcategoryController();
  dynamic _image;
  late String categoryName;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Subcategories',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(4.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          FutureBuilder(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Subcategory available'));
                } else {
                  return DropdownButton<CategoryModel>(
                      value: selectedCategory,
                      hint: Text('Select Category'),
                      items: snapshot.data!.map((CategoryModel category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                        debugPrint(
                            'selectedCategory : ${selectedCategory!.name}');
                      });
                }
              }),
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
                        : Text('Subcategory Image')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) {
                      categoryName = value;
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Subcategory name is required';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Enter Subcategory'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formKey.currentState!.reset();
                    _image = null;
                    selectedCategory = null;
                  });
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _subCategoryController.uploadSubCategory(
                        categoryId: selectedCategory!.id,
                        categoryName: selectedCategory!.name,
                        pickedImage: _image,
                        subCategoryName: categoryName,
                        context: context);

                    setState(() {
                      _formKey.currentState!.reset();
                      _image = null;
                      selectedCategory = null;
                    });
                  } else {
                    debugPrint('not valid');
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Pick Image'),
            ),
          ),
        ],
      ),
    );
  }
}
