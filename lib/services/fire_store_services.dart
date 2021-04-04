import 'package:buy_it_admin_panel/constants.dart';
import 'package:buy_it_admin_panel/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  final _fireStore = FirebaseFirestore.instance;
  final CollectionReference _productCollectionReference =
  FirebaseFirestore.instance.collection('Products');

  Future<void> addProductToFireStore(ProductModel productModel) async {
    return await _productCollectionReference
        .doc(productModel.pId)
        .set(productModel.toJson());
  }

  Stream<QuerySnapshot> getProducts() {
    return _productCollectionReference.snapshots();
  }

  Stream<QuerySnapshot> getOrders() {
    return _fireStore.collection(kOrders).snapshots();
  }


  Stream<QuerySnapshot> getOrderDetails(String documentId) {
    return _fireStore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  Future<void> deleteProductFromFireStore(String pId) async {
    return await _productCollectionReference.doc(pId).delete();
  }

  Future<void> updateProductFromFireStore(data, String pId) async {
    return await _productCollectionReference.doc(pId).update(data);
  }

}