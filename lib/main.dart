import 'package:buy_it_admin_panel/constants.dart';
import 'package:buy_it_admin_panel/provider/auth_view_model.dart';
import 'package:buy_it_admin_panel/provider/add_product_view_model.dart';
import 'package:buy_it_admin_panel/provider/edit_product_view_model.dart';
import 'package:buy_it_admin_panel/provider/manage_product_view_model.dart';
import 'package:buy_it_admin_panel/provider/model_hud.dart';
import 'package:buy_it_admin_panel/screens/admin_edit_product.dart';
import 'package:buy_it_admin_panel/screens/auth/login_screen.dart';
import 'package:buy_it_admin_panel/screens/auth/signup_screen.dart';
import 'package:buy_it_admin_panel/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/admin_add_product.dart';
import 'screens/admin_view_orders.dart';
import 'screens/admin_manage_product.dart';
import 'screens/admin_home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('Loading....'),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(
              providers:
              [
                ChangeNotifierProvider<ModelHud>(
                    create: (context) => ModelHud()),
                ChangeNotifierProvider<AuthViewModel>(
                    create: (context) => AuthViewModel()),
                ChangeNotifierProvider<AddProductViewModel>(
                    create: (context) => AddProductViewModel()),
                ChangeNotifierProvider<ManageProductViewModel>(
                    create: (context) => ManageProductViewModel()),
                ChangeNotifierProvider<EditProductViewModel>(
                    create: (context) => EditProductViewModel()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? AdminHome.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  AdminHome.id: (context) => AdminHome(),
                  AdminAddProduct.id: (context) => AdminAddProduct(),
                  AdminManageProduct.id: (context) => AdminManageProduct(),
                  AdminEditProduct.id: (context) => AdminEditProduct(),
                  AdminViewOrders.id: (context) => AdminViewOrders(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        }
    );
  }
}
