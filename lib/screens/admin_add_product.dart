import 'package:buy_it_admin_panel/provider/add_product_view_model.dart';
import 'package:buy_it_admin_panel/provider/model_hud.dart';
import 'package:buy_it_admin_panel/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class AdminAddProduct extends StatelessWidget {
  static String id = 'AdminAddProduct';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _productViewModel = Provider.of<AddProductViewModel>(context);
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
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
                      backgroundImage: _productViewModel.image == null
                          ? null
                          : FileImage(
                              _productViewModel.image,
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
                      onPressed: _productViewModel.getImage,
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
                        _productViewModel.name = value;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        _productViewModel.price = value;
                      },
                      hint: 'Product Price',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        _productViewModel.description = value;
                      },
                      hint: 'Product Description',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        _productViewModel.category = value;
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
                          _productViewModel.uploadImage(context);
                        }
                      },
                      child: Text(
                        'Upload',
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
      ),
    );
  }


}
