// ignore_for_file: prefer_const_constructors

import 'package:cart/screen/login.dart';
import 'package:cart/screen/product_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductTabView extends StatefulWidget {
  const ProductTabView({Key? key}) : super(key: key);

  @override
  _ProductTabViewState createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView> {
  SharedPreferences? logindata;
  String? username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata!.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Cart"),

          actions: [
            IconButton(
                icon: Icon(Icons.login_rounded),
                onPressed: () {
                  logindata!.setBool('login', true);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                }),
          ],
          bottom: TabBar(
            isScrollable: true,

            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              Tab(
                text: "Mobile",
              ),
              Tab(
                text: "Ac",
              ),
              Tab(
                text: "Laptop",
              ),
              Tab(
                text: "Bike",
              ),
              Tab(
                text: "Car",
              ),
            ],
          ),
        
        ),
        body: TabBarView(
          
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ProductListPage(productType: "Mobile"),
            ProductListPage(productType: "Ac"),
            ProductListPage(productType: "Laptop"),
            ProductListPage(productType: "Bike"),
            ProductListPage(productType: "Car"),
          ],
        ),
      ),
    );
  }
}
