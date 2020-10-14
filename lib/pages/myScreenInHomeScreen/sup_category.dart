import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/product/product_category.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

CategoriesApi categoriesApi = CategoriesApi();

  List<ProductCategory> category = [];
    ProductsApi productsApi = ProductsApi();
  bool loading = true;
  List<Product> productTag = [];
 // bool loading = true;
  @override
  void initState() {
    super.initState();
     productsApi.fetchProductsType2().then((value) {
     
      setState(() {
         productTag.addAll(value);
        loading = false;
      });
      print(productTag.length);
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
  Widget build(BuildContext context) {
    print(productTag.length);
    return Card(
      color:Colors.black54,
      elevation: 0,
      margin: EdgeInsets.all(7),
          child: Container(
        width: double.infinity,
        height: 205,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  (productTag.length==0)?Center(child:Text(productTag.length.toString())): GridView.builder(
            physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    dragStartBehavior: DragStartBehavior.start,
                      //controller: scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.95),
                      itemCount: productTag.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.orange ),
        ),
                          width: 88,
                          height: 88,
                          child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
                                                      child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: productTag[index].featureImage()),
                          ),
                            
                        );
                        
                      }),
        ),
      ),
    );
  }
}