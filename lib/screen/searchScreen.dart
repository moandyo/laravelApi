import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/search_product.dart';
import 'package:fluttershop/screen/singlePproduct.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';
//qqqqqqqqqqqqqqqq

import 'dart:convert';

import 'package:fluttershop/api/api_utilty.dart';
import 'package:fluttershop/product/product.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //SearchProduct searchProduct = SearchProduct();

  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Product>> search() async {
    //print(search);
    Map<String, String> headers = {'Accept': 'application/json'};

    Map<String, String> body = {
      'search': _searchController.text,
    };
    String url = ApiUti.SEARCH;
    http.Response response = await http.post(url, headers: headers, body: body);
    List<Product> product = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print(body);
      for (var item in body['data']) {
        // print(item);
        product.add(Product.fromJson(item));
      }

      return product;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            // height: 30,
            padding: EdgeInsets.all(4),
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.left,
              autofocus: true,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'search your product',
                hintStyle: TextStyle(fontSize: 18),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    search();
                  });

                  // print(search());
                }),
          ],
        ),
        body: FutureBuilder(
            future: search(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return error('no connection made');
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return loding();
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return error(snapshot.error.toString());
                  } else {
                    if (!snapshot.hasData) {
                      return error('no data');
                    } else {
                      //   print(snapshot.data);
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext contaxt, int index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SingleProduct(
                                          snapshot.data[index]);
                                    },
                                  ),
                                );
                              },
                              title: Text(snapshot.data[index].product_title),
                              leading: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      snapshot.data[index].featureImage()),
                            );
                          });
                      //print(snapshot.data['data'].product_id);
                      // this.productsCategories = snapshot.data;
                      // homeProductBloc.fetchProduct.add(this.productsCategories[0].category_id);
                      //return _screen(snapshot.data, context);
                    }
                  }
                  break;
              }
              return Container();
            }));
  }
}
