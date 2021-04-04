import 'package:buy_it_admin_panel/constants.dart';
import 'package:buy_it_admin_panel/screens/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_hud.dart';

class AuthViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String email, password, name;

  Future<void> signInWithEmailAndPasswordMethod(BuildContext context) async {
    final modelHUD = Provider.of<ModelHud>(context, listen: false);
    modelHUD.changeIsLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      modelHUD.changeIsLoading(false);
      Navigator.popAndPushNamed(context, AdminHome.id);
    } on FirebaseException catch (e) {
      modelHUD.changeIsLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    }
    // notifyListeners();
    modelHUD.changeIsLoading(false);
  }

  Future<void> signUpWithEmailAndPasswordMethod(BuildContext context) async {
    final modelHUD = Provider.of<ModelHud>(context, listen: false);
    modelHUD.changeIsLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      modelHUD.changeIsLoading(false);
      Navigator.pushNamed(context, AdminHome.id);
    } on FirebaseException catch (e) {
      modelHUD.changeIsLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    }

    modelHUD.changeIsLoading(false);
  }

  Future <void> keepUserLoggedIn(bool keepMeLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }

}
