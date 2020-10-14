import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/product/home_products.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/product/product_category.dart';
import 'package:fluttershop/screen/accountScreen.dart';
import 'package:fluttershop/screen/searchScreen.dart';
import 'package:fluttershop/screen/singlePproduct.dart';
import 'locaition_screen.dart';
import 'utilities/drawer_screen.dart';
import 'utilities/helpers_widget.dart';
import 'dart:math';

import 'wishilst_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController = ScrollController();
  int currentIndex = 0;

  List<ProductCategory> productsCategories;
  PageController _pageController;

  CategoriesApi categoriesApi = CategoriesApi();

  HomeProductBloc homeProductBloc = HomeProductBloc();
  //DoteStream doteStream = DoteStream();
  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    categoriesApi.fetchCategories();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    //doteStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    this.productsCategories = snapshot.data;
                    homeProductBloc.fetchProduct
                        .add(this.productsCategories[0].category_id);
                    return _screen(snapshot.data, context);
                  }
                }
                break;
            }
            return Container();
          }),
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
    tabController =
        TabController(initialIndex: 0, length: categories.length, vsync: this);
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 111,
                  height: 111,
                  child: Center(child: Text('الحساب')),
                  decoration: BoxDecoration(
                      color: Colors.cyan[500],
                      borderRadius: BorderRadius.circular(17)),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text('حسابي'),
                trailing: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text('الشراء لاحقا'),
                trailing: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WishlistScreen()));
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home '),
        backgroundColor: Colors.white,
        actions: <Widget>[
          //  Padding(
          //         padding: const EdgeInsets.only(right: 16),
          //          child: IconButton(
          // //   iconSize: 27.0,
          //    icon: Icon(Icons.location_on), onPressed:(){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LocaitionScreen()));
          //   }),
          //        ),
          //Padding(
          //     padding: const EdgeInsets.only(right: 16),
          //     child: IconButton(
          //   iconSize: 27.0,
          //      Navigator.push(context, MaterialPageRoute(builder: (context)=>WishlistScreen()));
          //    }),
          //  ),
          //     Padding(
          //      padding: const EdgeInsets.only(right: 16),
          //        child: IconButton(
          //    iconSize: 27.0,
          //    icon: Icon(Icons.account_circle), onPressed:(){
          //    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen()));
          //  }),
          // ),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                iconSize: 27.0,
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                }),
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.blue,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
          onTap: (int index) {
            homeProductBloc.fetchProduct
                .add(this.productsCategories[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: homeProductBloc.productsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return error('nothing');
                  break;
                case ConnectionState.waiting:
                  return loding();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return error(snapshot.error.toString());
                  } else {
                    if (!snapshot.hasData) {
                      return error('no data returned!');
                    } else {
                      return _drawProducts(snapshot.data, context);
                    }
                  }
                  break;
              }
              return Container();
            }),
      ),
    );
  }

  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 5;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);
    for (int index in indexes) {
      newProducts.add(products[index]);
    }
    return newProducts;
  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: topProducts.length,
                onPageChanged: (int index) {
                  dotsIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _gotoSingleProduct(topProducts[index], context);
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: topProducts[index].featureImage(),
                          fit: BoxFit.cover,
                        ),
                        //Image(
                        //fit:BoxFit.cover,
                        //image: NetworkImage(topProducts[index].featureImage())
                        //),
                      ),
                    ),
                  );
                }),
          ),
          ValueListenableBuilder(
              valueListenable: dotsIndex,
              builder: (context, value, _) {
                return Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _drawDots(topProducts.length, value),
                  ),
                );
              }),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 24),
              child: GridView.builder(
                shrinkWrap: true,
                
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.55),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _gotoSingleProduct(products[index], context);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 170,
                            child: Image(
                              image:
                                  NetworkImage(products[index].featureImage()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              products[index].product_title,
                              style: TextStyle(fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              products[index].product_price.toString() +
                                  '  دينار',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qty, int index) {
    List<Widget> widget = [];
    for (int i = 0; i < qty; i++) {
      widget.add(
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (i == index) ? Colors.blue : Colors.grey.shade300),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return widget;
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];
    for (ProductCategory category in categories) {
      tabs.add(Tab(text: category.category_name));
    }
    return tabs;
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SingleProduct(product);
        },
      ),
    );
  }
}
