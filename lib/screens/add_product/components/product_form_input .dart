import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import '../../../models/Product.dart';

class ProductFormInput extends StatefulWidget {
  final void Function(Product, File) onSubmit;

  const ProductFormInput({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _ProductFormInputState createState() => _ProductFormInputState();
}

class _ProductFormInputState extends State<ProductFormInput> {
  final _formKey = GlobalKey<FormState>();
  int id = 0;
  String title = '';
  String description = '';
  List<String> images = [];
  List<Color> colors = [];
  double rating = 0.0;
  double price = 0.0;
  bool isFavourite = false;
  bool isPopular = false;

  File? _imageFile;

  Future<void> _pickImage() async {
    // XFile? pickedImage = await ImagePicker().pickImage(source: source);
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
    print("11111111111111111111");
    print(_imageFile);
    // if (pickedImage != null) {
    //   setState(() {
    //     _imageFile = File(pickedImage.path);
    //   });
    //   // final storage = FirebaseStorage.instance;
    //   final reference = FirebaseStorage.instance.ref().child('images');
    //   final uploadTask = await reference.putFile(_imageFile!);
    //   String imageURL = await uploadTask.ref.getDownloadURL();
    //   print("555555555555555555555555555555");
    //   print(imageURL);
    // }
  }

  Future uploadFile() async {
    // final path = 'files/${_imageFile!.name}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(labelText: 'ID'),
            //     keyboardType: TextInputType.number,
            //     onSaved: (value) {
            //       id = int.parse(value!);
            //     },
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter an ID';
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(labelText: 'Title'),
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter a title';
            //       }
            //       return null;
            //     },
            //     onSaved: (value) {
            //       title = value!;
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(labelText: 'Description'),
            //     maxLines: null,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter a description';
            //       }
            //       return null;
            //     },
            //     onSaved: (value) {
            //       description = value!;
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration: InputDecoration(labelText: 'Price'),
            //     keyboardType: TextInputType.number,
            //     onSaved: (value) {
            //       price = double.parse(value!);
            //     },
            //     inputFormatters: [
            //       FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
            //     ],
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter a price';
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration: InputDecoration(labelText: 'Rating'),
            //     keyboardType: TextInputType.number,
            //     inputFormatters: [
            //       FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
            //     ],
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter a rating';
            //       }
            //       return null;
            //     },
            //     onSaved: (value) {
            //       rating = double.parse(value!);
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          height: 150,
                        )
                      : const Placeholder(
                          fallbackHeight: 150,
                        ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _pickImage();
                    },
                    child: const Text('Select Image'),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: TextFormField(
            //     decoration:
            //         InputDecoration(labelText: 'Colors (comma-separated)'),
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter colors';
            //       }
            //       return null;
            //     },
            //     onSaved: (value) {
            //       // You need to parse the colors and convert them to Color objects
            //       List<String> colorStrings = value!.split(',');
            //       colors = colorStrings
            //           .map((color) => Color(int.parse(color)))
            //           .toList();
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: CheckboxListTile(
            //     title: Text('Is Favourite'),
            //     value: isFavourite,
            //     onChanged: (value) {
            //       setState(() {
            //         isFavourite = value!;
            //       });
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: CheckboxListTile(
            //     title: Text('Is Popular'),
            //     value: isPopular,
            //     onChanged: (value) {
            //       setState(() {
            //         isPopular = value!;
            //       });
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  uploadFile();
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();

                  //   final product = Product(
                  //     id: id,
                  //     images: images,
                  //     colors: colors,
                  //     rating: rating,
                  //     price: price,
                  //     title: title,
                  //     description: description,
                  //     isFavourite: isFavourite,
                  //     isPopular: isPopular,
                  //   );

                  //   widget.onSubmit(product, _imageFile!);
                  // }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
