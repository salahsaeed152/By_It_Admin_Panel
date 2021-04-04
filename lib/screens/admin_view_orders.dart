import 'package:buy_it_admin_panel/models/order_model.dart';
import 'package:buy_it_admin_panel/screens/order_details.dart';
import 'package:buy_it_admin_panel/services/fire_store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AdminViewOrders extends StatelessWidget {
  static String id = 'AdminViewOrders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreService().getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orderModel = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              orderModel.add(OrderModel(
                documentId: doc.id,
                address: data[kAddress],
                totalPrice: data[kTotalPrice],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orderModel[index].documentId);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    color: kSecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Price = \$${orderModel[index].totalPrice.toString() }',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is ${orderModel[index].address}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orderModel.length,
            );
          } else {
            return Center(
              child: Text('Loading....'),
            );
          }
        },
      ),
    );
  }
}
