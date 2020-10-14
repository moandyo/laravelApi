import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/product/product_category.dart';
import 'package:fluttershop/screen/myWork/allProductByCategory.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';

class Bay extends StatefulWidget {
  @override
  _BayState createState() => _BayState();
}

class _BayState extends State<Bay> {
  CategoriesApi categoriesApi = CategoriesApi();

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDtawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset,
          0), //..scale(scaleFactor)..rotateY(isDtawerOpen?-0.5:0),
      duration: Duration(milliseconds: 550),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDtawerOpen ? 40.0 : 0)),
      // color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDtawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDtawerOpen = false;
                            });
                          })
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDtawerOpen = true;
                            });
                          }),
                  Text('weko'),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print('object');
                      })
                ],
              ),
            ),
            Container(
              height: 120,
              child: FutureBuilder(
                  future: categoriesApi.fetchCategories(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProductCategory>> snapshot) {
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
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext contaxt, int index) {
                                  return InkWell(
                                    onTap: () {
                                       _gotoSingleProduct(snapshot.data[index], context);
                                     // print(snapshot.data[index].category_id);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 50,
                                            width: 50,
                                            child: Text('atllist'),
                                          ),
                                          Text(snapshot
                                              .data[index].category_name)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        }
                        break;
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
  void _gotoSingleProduct(ProductCategory product, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AllProductByCategory(product);
        },
      ),
    );
  }
}
