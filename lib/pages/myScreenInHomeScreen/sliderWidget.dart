import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/screen/myWork/single_product_2.dart';
import 'package:fluttershop/screen/singlePproduct.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  ProductsApi productsApi = ProductsApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productsApi.fetchProductsType1(),
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
                  return CarouselSlider.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                             PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 540),
                                  pageBuilder:
                                      (context, animation, animationtow) {
                                    return SingleProducr2(snapshot.data[index]);
                                  },)
                                 // transitionsBuilder: (context, animationt,
                                  //    animationtow, child) {
                                 //   var begin = Offset(1, 0);
                                 //   var end = Offset(0, 0);
                                 //   var tween = Tween(begin: begin, end: end);
                                 //   var offsetAnimation =
                                  //      animationt.drive(tween);
                                 //   return SlideTransition(
                                  //      position: offsetAnimation,
                                  //      child: child);
                               //   })
                         //   MaterialPageRoute(
                            //  builder: (context) {
                          //      return SingleProducr2(snapshot.data[index]);
                          //    },
                          //  ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Hero(
                              tag: snapshot.data[index].images,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: snapshot.data[index].featureImage(),
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
                      );
                    },
                    options: CarouselOptions(
                        //   autoPlayAnimationDuration: Duration(milliseconds: 1500),
                        enlargeCenterPage: false,
                        autoPlay: true,
                        enableInfiniteScroll: true),
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
        });
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
