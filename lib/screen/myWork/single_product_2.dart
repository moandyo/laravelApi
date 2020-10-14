import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/order_api.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import '../singlePproduct.dart';

class SingleProducr2 extends StatefulWidget {
  final Product product;

  SingleProducr2(
    this.product,
  );

  @override
  _SingleProducr2State createState() => _SingleProducr2State();
}

class _SingleProducr2State extends State<SingleProducr2> {
final GlobalKey<ScaffoldState> scaffoldState= GlobalKey<ScaffoldState>();
ShowSnackBar(){
  scaffoldState.currentState.showSnackBar(SnackBar(content: Text('تم أرسال الطلب'),));
}

  int selected = 0;

bool _adding=false;
 OrderApi orderApi = OrderApi();
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
      key: scaffoldState,
      backgroundColor: Colors.blueGrey[50],
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.50,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: widget.product.images,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.product.images[selected],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    widget.product.images.length,
                    (index) => buildSmallPreview(index),
                  )
                ],
              ),
              _drawTitle(context),
              _drawDetails(context),
              _drawFatchSeem(context),
              _drawDetails(context),
            ],
          ),
        ),
        SafeArea(
          child: Container(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 42,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                    return  AlertDialog(
                      backgroundColor: Colors.white,
                        title: Text(
                          'تأكيد الشراء',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        content: Text('بعد تأكد الطلب سيتم توصيله في اقرب وقت'),
                        actions: [
                            FlatButton(onPressed: (){
                                Navigator.pop(context);
                            }, child: Text('ألغاء')),
                          FlatButton(
                           child: Text('تأكيد'),
                          onPressed: ()async{
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
               Navigator.pop(context);
              setState(() {
                _adding = false;
              });
              
               ShowSnackBar();
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text('تم اكمال الطلب')));
              // print(widget.user.user_id);
            }
                          },),
                         
                        ],
                      );
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.73,
                  height: 55,
                  child:  (_adding)
              ? Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
              ):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.product.product_price.toString()),
                      Text(
                        'شراء الأن',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  )),
            ),
          ),
        )
      ]),
    );

    /*Scaffold(
      body: Stack(
        children: [
          Container(
            // width: 222,
            height: 390,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.product.featureImage()),
              ),
            ),
            child: SafeArea(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )),
          ),
          Positioned(
              top: 370,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(widget.product.product_title)),
                        Expanded(
                            child:
                                Text(widget.product.product_price.toString())),
                      ],
                    ),
                    
                  ],
                ),
              )),
        ],
      ),
    );*/
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin: EdgeInsets.all(7),
        // padding: EdgeInsets.all(1),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected == index ? Colors.orange : Colors.blueGrey[50],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
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
        ),
      ),
    );
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 220,
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
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 900),
                            pageBuilder: (context, animation, animationtow) {
                              return SingleProducr2(productTag[index]);
                            },
                          ),
                        );
                        //   print(category[index].category_id);
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          bottom: 6,
                          top: 6,
                          left: 11,
                        ),
                        shadowColor: Colors.blueGrey[50],
                        elevation: 8.0,
                        child: Container(
                          //   color: Colors.amberAccent,
                          margin: EdgeInsets.all(9),
                          height: 190,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 140,
                                //padding: EdgeInsets.all(10),
                                //  margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Hero(
                                    tag: productTag[index].images,
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            productTag[index].featureImage()),
                                  ),
                                ),
                              ),
                              Text(productTag[index].product_title)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
