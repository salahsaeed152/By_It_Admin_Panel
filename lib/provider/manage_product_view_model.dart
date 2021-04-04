import 'package:buy_it_admin_panel/models/product_model.dart';
import 'package:buy_it_admin_panel/services/fire_store_services.dart';
import 'package:flutter/material.dart';

class ManageProductViewModel extends ChangeNotifier {
  // List<ProductModel> _productModel = [];
  //
  // List<ProductModel> get productModel => _productModel;

  Future<List<ProductModel>>getProducts(List<ProductModel> productModel) async {
     final snapShots =  FireStoreService().getProducts();
     await for(var snapShot in snapShots){
       print(snapShot.docs.length);
       for(var doc in snapShot.docs){
         var data = doc.data();
         productModel.add(ProductModel.fromJson(data));
       }
     }
     print('you are here');
     return productModel;
  }


  Future<List<ProductModel>>getOrders(List<ProductModel> productModel) async {
    final snapShots =  FireStoreService().getProducts();
    await for(var snapShot in snapShots){
      print(snapShot.docs.length);
      for(var doc in snapShot.docs){
        var data = doc.data();
        productModel.add(ProductModel.fromJson(data));
      }
    }
    print('you are here');
    return productModel;
  }

  deleteProduct(String pId) async{
    await FireStoreService().deleteProductFromFireStore(pId);
  }


}