

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/screen/myWork/single_product_2.dart';
import 'package:fluttershop/screen/singlePproduct.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SpeshleProduct extends StatefulWidget {
  @override
  _SpeshleProductState createState() => _SpeshleProductState();
}

class _SpeshleProductState extends State<SpeshleProduct> {
  PageController _pageController;
  int pageIndex = 0;

  ProductsApi productsApi = ProductsApi();
  bool loading = true;
  List<Product> productTag = [];
  @override
  void initState() {
    super.initState();
    productsApi.fetchProductsType2().then((value) {
      setState(() {
         productTag.addAll(value);
        loading = false;
      });
    });

    _pageController = PageController(viewportFraction: 0.75);
  }

  //ProductsApi productsApi = ProductsApi();
  @override
  Widget build(BuildContext context) {
     // print( productTag.length);
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 11,top: 11),
          child: Container(
          width: double.infinity,
          height: 433,
          child: (productTag.length==0)?Center(child:Text(productTag.length.toString())): PageView.builder(
      controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        itemCount: productTag.length,
        itemBuilder: (BuildContext contaxt, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnconstrainedBox(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                //     curve: Curves.easeInOut,
                height: pageIndex == index ? 360 : 280,
                width: pageIndex == index ? 240 : 180,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration (milliseconds: 900),
                        pageBuilder: (context,animation,animationtow){
                        return SingleProducr2(productTag[index]);
                      },
                      
                    //    transitionsBuilder: (context ,animationt,animationtow,child){
                    //      var begin = Offset(1, 0);
                    //      var end = Offset(0, 0);
                    //      var tween = Tween(begin: begin,end:end);
                    //      var offsetAnimation = animationt.drive(tween);
                    //      return SlideTransition(position: offsetAnimation,child:child);
                   //     }
                      )
                      //MaterialPageRoute(
                        //builder: (context) {
                         // return SingleProduct(productTag[index]);
                       // },
                     // ),
                    );
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin:  const EdgeInsets.only(bottom: 17),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 13,
                                offset: Offset(0, 8)),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(
                          tag:productTag[index].images,
                                                    child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: productTag[index].featureImage(),
                            placeholder: (BuildContext, U) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                              ),
                            ),
                            errorWidget: (BuildContext, u, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 0,
                      child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color:Colors.lime[900],
                        borderRadius: BorderRadius.circular(13), boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 13,
                                offset: Offset(0, 8)),
                          ]
                      ),
                      child: Icon(Icons.shopping_cart,color:Colors.white),
                    ),),
                  ]),
                ),
              ),
            ),
          );
        }),
        ),
    );

    /*FutureBuilder(
        future: productsApi.fetchProductsType2(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
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
                  return Container(
                    width: double.infinity,
                    height: 433,
                    child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            pageIndex = index;
                          });
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext contaxt, int index) {
                          return UnconstrainedBox(
                            alignment: Alignment.centerLeft,
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.bounceIn,
                                height: pageIndex==index ? 360:280,
                                width: pageIndex==index?240:180,
                              child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            snapshot.data[index].featureImage(),
                                        placeholder: (BuildContext, U) =>
                                            Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.0,
                                          ),
                                        ),
                                        errorWidget: (BuildContext, u, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                          );
                        }),
                  );

                  /* ListView.builder(
                         scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext contaxt, int index) {
                        // print(category[index].category_image);
                          //print(category[index].category_name);
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 50,
                                  width: 50,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot.data[index].featureImage()),
                                ),
                                Text(snapshot.data[index].product_price.toString())
                              ],
                            ),
                          );
                        });*/
                }
              }
              break;
          }
          return Container();
        });*/
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
