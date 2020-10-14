import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/pages/wedget/header.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/screen/singlePproduct.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'myScreenInHomeScreen/sliderWidget.dart';
import 'myScreenInHomeScreen/speshleProduct.dart';
import 'myScreenInHomeScreen/sup_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 final _scrollController = TrackingScrollController();

  ProductsApi productsApi = ProductsApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lopehope',style: TextStyle(color:Colors.blueGrey[800]),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.menu,),color: Colors.black, onPressed: (){}) ,
        actions: [IconButton(icon: Icon(Icons.search,),color: Colors.black, onPressed: (){})],
      ),
      backgroundColor: Colors.blueGrey[50],
        body: SafeArea(
                  child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
          child: Column(
            children: <Widget>[
               buildPadding('عرض الكل','اعلانات '),
              SizedBox(height: 11,),
              SliderWidget(),
               SizedBox(height: 11,),
               buildPadding('عرض الكل','اعلى الفئات'),
              SubCategoryScreen(),
               SizedBox(height: 11,),
                buildPadding('عرض الكل','الأكثر شراء '),
              SpeshleProduct(),
               buildPadding('عرض الكل','اعلانات '),
              SpeshleProduct(),
              
              ],
          ),
      ),
    //  Header(_scrollController),
            ],
          ),
        ));

    /*Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Home Screen'),
          ),
        ),
        body: FutureBuilder(
            future: productsApi.fetchProductsType(),
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
                      return Column(
                        children: [
                          Text('اعلانات',style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
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
                                );
                              },
                              options: CarouselOptions(
                             //   autoPlayAnimationDuration: Duration(milliseconds: 1500),
                                  enlargeCenterPage: false,
                                  autoPlay: true,
                                  enableInfiniteScroll: true),
                            ),
                          ),
                          Container(
                            height: 111,
                            color: Colors.red,
                          ),
                        ],
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
            }));*/
  }

  Padding buildPadding(String title, String text) {
    return Padding(
               padding: const EdgeInsets.only(left:11,right: 29),
               child: Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   Row(
                     children: [
                       Icon(Icons.arrow_forward_ios,textDirection: TextDirection.rtl ,size: 14,),
                       SizedBox(width: 11,),
                     Text(title,style: TextStyle(color:Colors.blueGrey[800]),),
                   ],),
                   Text(text ,style: TextStyle(
          fontSize: 17,
          height: 2,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600),)
                 ],),
               ),
             );
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
