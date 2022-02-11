// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cart/common/constants.dart';
import 'package:cart/data/sqlite_helper.dart';
import 'package:cart/model/cart__model.dart';

import 'package:cart/screen/tab_view.dart';
import 'package:cart/widget/cart_text.dart';
import 'package:cart/widget/description.dart';
import 'package:flutter/material.dart';

class AddEditProduct extends StatefulWidget {
  final int? id;
  const AddEditProduct({Key? key, this.id}) : super(key: key);

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final CartDbProvider? _cartProvider = CartDbProvider();
  CartDataModel? cartDataModel;
  List<CartDataModel>? listCartDataModel;
  String dropdownvalue = 'Mobile';

  var items = [
    'Mobile',
    'Ac',
    'Laptop',
    'Bike',
    'Car',
  ];
  void _submitResult(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    if (widget.id == null) {
      cartDataModel!.productType = dropdownvalue;
      _cartProvider!.addItem(cartDataModel!, productTableDb);

     
      showAlertDialog(context, "Product Added Successfully", 1);
      return;
    }
    _cartProvider!.updateCart(widget.id as int, cartDataModel!, productTableDb);

   
    showAlertDialog(context, "Product Updated Successfully", 2);
    return;
  }

  showAlertDialog(BuildContext context, String msg, int stauts) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductTabView()));
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    CartDbProvider bdObj = CartDbProvider();
    listCartDataModel = await bdObj.fetchProduct(productTableDb);
    if (widget.id == null) {
      cartDataModel = CartDataModel();
    } else {
      for (var element in listCartDataModel!) {
        if (element.id == widget.id) {
          cartDataModel = element;
         
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.id == null ? "Add New Product" : "Update Product"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductTabView()));
                }),
          ],
        ),
        body: cartDataModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  initialValue: widget.id != null
                                      ? cartDataModel!.productName
                                      : "",
                                  withAsterisk: true,
                                  labelText: "ProductName",
                                  hintText: "Please Enter the Product Name",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cartDataModel!.productName = value;
                                  },
                                ),
                              ),
                              widget.id == null
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 65,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CartLabelText(
                                            text: "Select the product type",
                                          ),
                                          DropdownButton(
                                            isExpanded: true,
                                            value: dropdownvalue,
                                            hint:
                                                Text("Please select the type"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              dropdownvalue = value.toString();
                                            },
                                          ),
                                        ],
                                      ))
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TitleAndDescription(
                                          title: "ProductType",
                                          desc: cartDataModel!.productType,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  initialValue: widget.id != null
                                      ? cartDataModel!.modelNumber
                                      : "",
                                  withAsterisk: true,
                                  labelText: "ModelNumber",
                                  hintText: "Please Enter the ModelNumber",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cartDataModel!.modelNumber = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  initialValue: widget.id != null
                                      ? cartDataModel!.price
                                      : "",
                                  withAsterisk: true,
                                  labelText: "Price",
                                  hintText: "Please Enter the Price",
                                  textInputType: TextInputType.number,
                                  maxLength: 6,
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cartDataModel!.price = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  initialValue: widget.id != null
                                      ? cartDataModel!.manufactureAddress
                                      : "",
                                  withAsterisk: true,
                                  labelText: "ManufactureAddress",
                                  hintText:
                                      "Please Enter the ManufactureAddress",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cartDataModel!.manufactureAddress = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  initialValue: widget.id != null
                                      ? cartDataModel!.manufactureDate
                                      : "",
                                  withAsterisk: true,
                                  labelText: "ManufactureDate",
                                  hintText: "Please Enter the ManufactureDate",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cartDataModel!.manufactureDate = value;
                                  },
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 300,
                                    minWidth: 120,
                                    minHeight: 50),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => secondaryTextColor),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              secondaryTextColor),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: secondaryTextColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _submitResult(context);
                                    },
                              
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                     
                                      child: Text(
                                        widget.id == null ? "Submit" : "Update",
                                      
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 14,
                                          fontWeight: fontWeight600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ));
  }
}
