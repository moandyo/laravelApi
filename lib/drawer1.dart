import 'dart:convert';

import 'package:flutter/material.dart';

import 'api/api_utilty.dart';
import 'api/categories_api.dart';
import 'product/product.dart';
import 'product/product_category.dart';
import 'screen/utilities/helpers_widget.dart';

import 'package:http/http.dart' as http;

class Drawer1 extends StatefulWidget {
  @override
  _Drawer1State createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {


List<ProductCategory> list=[];

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0;

  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[600],
    );
  }
}
