

import 'dart:async';
import 'package:fluttershop/api/categories_api.dart';
import 'package:fluttershop/api/product_api.dart';
import 'package:fluttershop/contracts/contracts.dart';
import 'package:fluttershop/product/product.dart';

class HomeProductBloc implements Disposble {

List<Product> product;
 final StreamController<List<Product>> _productsController = StreamController<List<Product>>.broadcast();
 final StreamController<int> _categoryController = StreamController<int>.broadcast();

   Stream<List<Product>> get productsStream => _productsController.stream;

   StreamSink<int> get fetchProduct => _categoryController.sink;
   Stream<int> get category => _categoryController.stream;

   int categoryID;

   CategoriesApi categoriesApi = CategoriesApi();
   HomeProductBloc(){
     
      product = [];
     _productsController.add(this.product);
     _categoryController.add(this.categoryID);
   _categoryController.stream.listen(_fetchCategoriesFromApi);
   
   }

   Future<void> _fetchCategoriesFromApi(int category) async{
    this.product = await categoriesApi.fetchCategoriesByCategory(category, 1);
    _productsController.add(this.product);
   }

  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
   
  }

}