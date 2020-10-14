import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/wishlist_api.dart';
import 'package:fluttershop/wishlist/wishlist.dart';

import 'singlePproduct.dart';
import 'utilities/helpers_widget.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool _adding = false;
  WishlistApi wishlistApi = WishlistApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('wishlist'),
          ),
        ),
        body: FutureBuilder(
            future: wishlistApi.getWishlist(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Wishlist>> snapshot) {
              print(snapshot.data.length);
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
                    if (!snapshot.hasData || snapshot.data == null) {
                      return error('no data');
                    } else {
                      if (snapshot.data.isEmpty) {
                        return Center(child: Text('ليس لديك منتجات'));
                      } else {
                        return (snapshot.data.length == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.length == null
                                    ? 0
                                    : snapshot.data.length,
                                itemBuilder: (BuildContext contaxt, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return SingleProduct(
                                                  snapshot.data[index].product);
                                            },
                                          ),
                                        );
                                      },
                                      title: Text(snapshot
                                          .data[index].product.product_price
                                          .toString()),
                                      leading: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: snapshot.data[index].product
                                              .featureImage()),
                                      trailing: IconButton(
                                          icon: Icon(Icons.delete_forever),
                                          color: Colors.red.shade500,
                                          onPressed: () async {
                                            setState(() {
                                              _adding = true;
                                            });
                                            await wishlistApi.deletWishlist(
                                                snapshot
                                                    .data[index].wishlistID);
                                            setState(() {
                                              _adding = false;
                                            });
                                          }),
                                    ),
                                  );
                                }));
                      }
                    }
                  }
                  break;
              }
              return Container();
            }));
  }
}
