import 'package:buy_it_admin_panel/constants.dart';
import 'package:buy_it_admin_panel/models/product_model.dart';
import 'package:buy_it_admin_panel/provider/edit_product_view_model.dart';
import 'package:buy_it_admin_panel/provider/model_hud.dart';
import 'package:buy_it_admin_panel/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AdminEditProduct extends StatelessWidget {
  static String id = 'AdminEditProduct';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _editProductViewModel = Provider.of<EditProductViewModel>(context);
    ProductModel productModel = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: _editProductViewModel.image == null
                        ? null
                        : FileImage(
                      _editProductViewModel.image,
                    ),
                    radius: 120,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: _editProductViewModel.getImage,
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormField(
                    hint: 'Product Name',
                    onSaved: (value) {
                      _editProductViewModel.name = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      _editProductViewModel.price = value;
                    },
                    hint: 'Product Price',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      _editProductViewModel.description = value;
                    },
                    hint: 'Product Description',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      _editProductViewModel.category = value;
                    },
                    hint: 'Product Category',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        _editProductViewModel.uploadImage(context, productModel.pId);
                        _editProductViewModel.image = null;
                        _globalKey.currentState.reset();
                      }
                    },
                    child: Text(
                      'Edit Product',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
