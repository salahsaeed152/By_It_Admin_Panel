import 'package:buy_it_admin_panel/models/product_model.dart';
import 'package:buy_it_admin_panel/provider/manage_product_view_model.dart';
import 'package:buy_it_admin_panel/screens/admin_edit_product.dart';
import 'package:buy_it_admin_panel/services/fire_store_services.dart';
import 'package:buy_it_admin_panel/widgets/custom_popUp_menu.dart';
import 'package:buy_it_admin_panel/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminManageProduct extends StatelessWidget {
  static String id = 'AdminManageProduct';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _gridViewProduct(context),
      ),
    );
  }

  Widget _gridViewProduct(BuildContext context) {
    final _manageProductViewModel = Provider.of<ManageProductViewModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: height,
          child: StreamBuilder<QuerySnapshot>(
              stream: FireStoreService().getProducts(),
              builder: (context, snapShot) {
                {
                  if (snapShot.hasData) {
                    List<ProductModel> productModel = [];
                    for (var doc in snapShot.data.docs) {
                      var data = doc.data();
                      productModel.add(ProductModel.fromJson(data));
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .8,
                      ),

                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: GestureDetector(
                          onTapUp: (details) async {
                            double dx = details.globalPosition.dx;
                            double dy = details.globalPosition.dy;
                            double dx2 = width - dx;
                            double dy2 = height - dy;
                            await showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                items: [
                                  MyPopupMenuItem(
                                    onClick: () {
                                      Navigator.pushNamed(context, AdminEditProduct.id, arguments: productModel[index]);
                                    },
                                    child: Text('Edit'),
                                  ),
                                  MyPopupMenuItem(
                                    onClick: () {
                                      _manageProductViewModel.deleteProduct(productModel[index].pId);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ]
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(productModel[index].pImageUrl),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Opacity(
                                  opacity: .6,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            productModel[index].pName,
                                            style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text('\$ ${productModel[index].pPrice}')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      itemCount: productModel.length,
                    );
                  } else {
                    return Center(
                      child: CustomText(
                        text: 'Loading.....',
                        alignment: Alignment.center,
                        fontSize: 18,
                      ),
                    );
                  }
                }
              }),
        ),
      ],
    );
  }
}
