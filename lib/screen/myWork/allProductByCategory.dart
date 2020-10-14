import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/product/product_category.dart';
import 'package:fluttershop/screen/myWork/single_product_2.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';

import '../singlePproduct.dart';

class AllProductByCategory extends StatefulWidget {
  final ProductCategory product;
  AllProductByCategory(this.product);
  @override
  _AllProductByCategoryState createState() => _AllProductByCategoryState();
}

class _AllProductByCategoryState extends State<AllProductByCategory> {
  CategoriesApi categoriesApi = CategoriesApi();
 int currentPage = 1;
 int page = 5;

 ScrollController scrollController = ScrollController();
  List<Product> category=[];
 bool loading= true;
@override
  void initState() {
    super.initState();
    fetchNews();
    scrollController.addListener(() { 
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        fetchNews();
      }
    });
  }
  
fetchNews(){
  categoriesApi.fetchCategoriesByCategory( widget.product.category_id, currentPage).then((value){
     category.addAll(value);
     setState(() {
       loading = false;
       if(currentPage!=page){
         print(page);
         currentPage++;
         print(category.length);
       }
     });
     print(category.length);
    });
}
  @override
  void dispose() {
     scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //print(widget.product.category_id);
    return Scaffold(
      backgroundColor:  Colors.blueGrey[50],
      appBar: AppBar(title: Text(widget.product.category_id.toString())),
      body: Container(
        // height: 120,
        child:loading ? Center(child: CircularProgressIndicator(),): Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 24),
                        child: GridView.builder(
                          controller: scrollController,
                            shrinkWrap: true,

                            //controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 0.70),
                            itemCount: category.length+1,
                            itemBuilder: (BuildContext context,int index) {
                              if(index==category.length){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                     PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 940),
                                  pageBuilder:
                                      (context, animation, animationtow) {
                                    return SingleProducr2(category[index]);
                                  },)
                                  );
                                  //_gotoSingleProduct(products[index], context);
                                },
                                child: Card(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 170,
                                        child: Hero(
                                          tag: category[index].images,
                                                                                  child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: category[index].featureImage(),
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
                                         category[index].product_title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          category[index].product_price
                                                  .toString() +
                                              '  دينار',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade500),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
      ),
    );
  }
}