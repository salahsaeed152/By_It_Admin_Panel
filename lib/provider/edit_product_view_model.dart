import 'dart:io';

import 'package:buy_it_admin_panel/models/product_model.dart';
import 'package:buy_it_admin_panel/provider/model_hud.dart';
import 'package:buy_it_admin_panel/services/fire_store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class EditProductViewModel extends ChangeNotifier {
  String name, price, description, category;

  File image;

  final CollectionReference _productCollectionReference =
  FirebaseFirestore.instance.collection('Products');


  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    notifyListeners();
  }

  void uploadImage(BuildContext context, String pId) async {
    final modelHUD = Provider.of<ModelHud>(context, listen: false);
    modelHUD.changeIsLoading(true);
    try {
      FirebaseStorage.instanceFor(bucket: 'gs://buy-it-d6bfe.appspot.com');
      Reference ref =
          FirebaseStorage.instance.ref().child(path.basename(image.path));
      UploadTask storageUploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      String _url = await taskSnapshot.ref.getDownloadURL();
      updateProduct(pId, _url);
      modelHUD.changeIsLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('success'),
        ),
      );
    } catch (ex) {
      modelHUD.changeIsLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.message),
        ),
      );
    }
    notifyListeners();
  }

  void updateProduct(String pId, String imageUrl) async {
    ProductModel productModel = ProductModel(
      pName: name,
      pPrice: price,
      pImageUrl: imageUrl,
      pDescription: description,
      pCategory: category,
      pId: _productCollectionReference.doc().id,
    );
    await FireStoreService().updateProductFromFireStore(productModel.toJson(), pId);
    notifyListeners();
  }

}
