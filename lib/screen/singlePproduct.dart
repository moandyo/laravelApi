import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/api/order_api.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/api/wishlist_api.dart';

import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/product/product_category.dart';
import 'package:fluttershop/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(
    this.product,
  );
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  PageController _pageController;
  int _pageIndex;

  OrderApi orderApi = OrderApi();
  WishlistApi wishlistApi = WishlistApi();
  bool _adding = false;

  ProductsApi productsApi = ProductsApi();

  List<Product> productTag = [];

  bool loading = true;
  @override
  void initState() {
    super.initState();
    productsApi.fetchProductsTag(widget.product.product_tag).then((value) {
      productTag.addAll(value);
      setState(() {
        loading = false;
      });
      // print(category.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(1.0),
        title: Text(widget.product.product_title),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                int userId = pref.getInt('user_id');
                setState(() {
                  _adding = true;
                });
                await wishlistApi.addWishlist(
                    userId, widget.product.product_id);
                setState(() {
                  _adding = false;
                });
              }),
        ],
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent.shade700,
          child: (_adding)
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Icon(Icons.shopping_cart),
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            int userId = pref.getInt('user_id');
            if (userId == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else {
              //TODO: ADD TO CART
              setState(() {
                _adding = true;
              });
              await orderApi.addOrder(userId, widget.product.product_id);
              setState(() {
                _adding = false;
              });
              // print(widget.user.user_id);
            }
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 11,left: 71),
        child: Material(
          borderRadius: BorderRadius.circular(22),
          color: Colors.brown,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22)
            ),
            //child: Colors.brown,
            width: 222,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text('data'),
              Text('jhhhh')
            ],),
          ),
        ),
      ),
    );
  }

  Widget _drawScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: _drawImageGallery(context)),
          _drawTitle(context),
          _drawDetails(context),
          _drawFatchSeem(context),
          _drawDetails(context),
        ],
      ),
    );
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
        itemCount: widget.product.images.length,
        itemBuilder: (context, int index) {
          return Container(
            // padding: EdgeInsets.all(8),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.product.images[index],
              placeholder: (BuildContext, U) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                ),
              ),
              errorWidget: (BuildContext, u, error) => Icon(Icons.error),
            ),
            //Image(
            //fit: BoxFit.cover,
            //image: NetworkImage(widget.product.images[index])),
          );
        });
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(widget.product.productCategory.category_name)
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.product.product_price.toString() + ' دينار',
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _drawDetails(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      child: Text(
        widget.product.product_description,
        style: TextStyle(
            fontSize: 14,
            height: 2,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  _drawFatchSeem(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productTag.length,
                itemBuilder: (BuildContext contaxt, int index) {
                  // print(category[index].category_image);
                  //print(category[index].category_name);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SingleProduct(productTag[index]);
                          },
                        ),
                      );
                      //   print(category[index].category_id);
                    },
                    child: Container(
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
                                imageUrl: productTag[index].featureImage()),
                          ),
                          //  Text(category[index].category_name)
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
