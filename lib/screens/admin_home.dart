import 'package:buy_it_admin_panel/screens/admin_add_product.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/admin_manage_product.dart';
import 'admin_view_orders.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AdminAddProduct.id);
            },
            child: Text('Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AdminManageProduct.id);
            },
            child: Text('Edit Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AdminViewOrders.id);
            },
            child: Text('View Orders',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

