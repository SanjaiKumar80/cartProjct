// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cart/common/constants.dart';
import 'package:cart/data/sqlite_helper.dart';
import 'package:cart/model/cart__model.dart';
import 'package:cart/screen/add_edit_product.dart';
import 'package:cart/widget/description.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final String productType;
  const ProductListPage({Key? key, required this.productType})
      : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<CartDataModel>? cartDataModel = [];

  @override
  void initState() {
    super.initState();
    CartDbProvider bdObj = CartDbProvider();
    bdObj.init();
    _getAllProduct(context);
    setState(() {});
  }

  Future<void> _getAllProduct(BuildContext context) async {
    List<CartDataModel> allProductList;
    CartDbProvider bdObj = CartDbProvider();

    allProductList = await bdObj.fetchProduct(productTableDb);

    cartDataModel = allProductList
        .where((element) =>
            element.productType!.toUpperCase() ==
            widget.productType.toUpperCase())
        .toList();
    // allProductList.forEach((element) {
    //   if (element.productType!.trim().toLowerCase() ==
    //       widget.productType.trim().toLowerCase()) {
    //     cartDataModel!.add(element);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
              future: _getAllProduct(context),
              builder: (ctx, resultSnapshot) {
                switch (resultSnapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('initiate data call');
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (resultSnapshot.hasError) {
                      return const Text('error in fetching data');
                    } else {
                    
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cartDataModel!.isEmpty
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: warningColor,
                                        ),
                                        Text(
                                            "No Product found in this categrory")
                                      ]),
                                ),
                              )
                            //Text("No Product found in this categrory")
                            : ReorderableListView(
                                key: Key('builder $cartDataModel.toString()'),
                                scrollController:
                                    ScrollController(initialScrollOffset: 50),
                                scrollDirection: Axis.vertical,
                                children: [
                                  for (int index = 0;
                                      index < cartDataModel!.length;
                                      index++)
                                    Dismissible(
                                        key: Key(index.toString()),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) async {
                                          CartDbProvider bdObj =
                                              CartDbProvider();
                                          await bdObj.deleteCart(
                                              cartDataModel![index].id!,
                                              productTableDb);
                                          setState(() {
                                            _getAllProduct(context);
                                          });
                                          // ignore: deprecated_member_use
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "product has been deleted successfully")));
                                        },
                                        child: Card(
                                          shadowColor: Colors.grey,

                                          child: ExpansionTile(
                                            maintainState: true,

                                            key: Key(index.toString()),

                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .platform,
                                            title: Row(
                                              children: [
                                                TitleAndDescription(
                                                    title: "ProductName",
                                                    desc: cartDataModel![index]
                                                        .productName!),
                                                Spacer(),
                                                TitleAndDescription(
                                                    title: "ModelNumber",
                                                    desc: cartDataModel![index]
                                                        .modelNumber!),
                                                Spacer(),
                                                TitleAndDescription(
                                                    title: "Price",
                                                    desc: cartDataModel![index]
                                                        .price!,
                                                        
                                                    unit: "Rs:"),
                                              ],
                                            ),

                                            children: [
                                              Row(
                                                children: [
                                                  TitleAndDescription(
                                                      title: "ManufactureDate",
                                                      desc: cartDataModel![
                                                              index]
                                                          .manufactureDate!),
                                                  Spacer(),
                                                  TitleAndDescription(
                                                      title:
                                                          "ManufactureAddress",
                                                      desc: cartDataModel![
                                                              index]
                                                          .manufactureAddress!),
                                                  Spacer(),
                                                  IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      onPressed: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddEditProduct(
                                                                    id: cartDataModel![
                                                                            index]
                                                                        .id!)));
                                                      }),
                                                ],
                                              )
                                            ],

                                         
                                          ),
                                        ))
                                ],
                                onReorder: (int oldIndex, int newIndex) {
                                  setState(() {
                                    if (oldIndex < newIndex) {
                                      newIndex -= 1;
                                    }
                                    final item =
                                        cartDataModel!.removeAt(oldIndex);
                                    cartDataModel!.insert(newIndex, item);
                                  });
                                },
                              ),
                      );
                     
                    }
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: secondaryTextColor,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditProduct()));
          },
        ));
  }
}
