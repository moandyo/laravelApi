import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/api/topProduct_api.dart';
import 'package:fluttershop/models/topProduct.dart';
import 'package:fluttershop/product/product_category.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {

ScrollController scrollController = ScrollController();

  CategoriesApi categoriesApi = CategoriesApi();
  TopProductsApi topProductsApi= TopProductsApi();

  List<ProductCategory> category = [];
  
 // List<TopProduct> topProduct=[];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    categoriesApi.fetchCategories().then((value) {
      category.addAll(value);
      setState(() {
        loading = false;
      });
     // print(category.length);
    });

   /* topProductsApi.fetchTopProducts(1).then((value) {
      topProduct.addAll(value);
      setState(() {
        loading = false;
      });
      //print(topProduct.length);
    });*/
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top:38.0),
        child: Container(
        //  height: 66,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.70),
                     scrollDirection: Axis.vertical,
                    itemCount: category.length,
                    itemBuilder: (BuildContext contaxt, int index) {
                    // print(category[index].category_image);
                      //print(category[index].category_name);
                      return InkWell(
                        onTap: () {
                        //   print(category[index].category_id);
                        },
                        child: Container(
                          color: Colors.white,
                         /// height: 170,
                          child: Column(
                            children: [
                              Container(
                              //  padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 150,
                                width: 150,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: category[index].category_image),
                              ),
                             Text(category[index].category_name)
                            ],
                          ),
                        ),
                      );
                    })),
      ),
    );
  }
}
