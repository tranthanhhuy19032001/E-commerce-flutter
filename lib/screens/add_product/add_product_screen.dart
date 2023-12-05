import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/product_form_input .dart';

class AddProductScreen extends StatefulWidget {
  static String routeName = "/add_product";
  const AddProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? imageUrl;
  Future<void> handleFormSubmission(Product product, File imageFile) async {
    print('Submitted Product: $product');
    print('ImageFile: $imageFile');

    String uniqueFileNamne = DateTime.now().millisecondsSinceEpoch.toString();

    //get a reference to storage root
    final storageRef = FirebaseStorage.instance.ref();

    // Create a child reference
    // imagesRef now points to "images"
    final imagesRef = storageRef.child("images");

    // Child references can also take paths
    // spaceRef now points to "images/space.jpg
    // imagesRef still points to "images"
    final referenceImageToUpload = imagesRef.child(uniqueFileNamne);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print(user);
        //Store the file
        await referenceImageToUpload.putFile(File(imageFile.path));
        //Success: get the download URL
        imageUrl = await referenceImageToUpload.getDownloadURL();
        print(imageUrl);
      }
    } catch (e) {
      //Some error occurred
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ProductFormInput(
            onSubmit: handleFormSubmission,
          ),
        ),
      ),
    );
  }
}
