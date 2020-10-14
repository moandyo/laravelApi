import 'dart:convert';

import 'package:fluttershop/wishlist/wishlist.dart';
import 'package:http/http.dart' as http;

import 'package:fluttershop/api/api_utilty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistApi{

  Future<bool> addWishlist(int userID, int productID)async{
   
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
String apiToken = sharedPreferences.get('api_token');

   String url = ApiUti.WESHLIST ;
   Map<String,String>headers = {
     'Accept' : 'application/json',
     'Authorization' : 'Bearer ' + apiToken
   };
   

   Map<String,dynamic>body = {
     'product_id' : productID.toString(),
     'user_id' : userID.toString()
   };

  http.Response response = await http.post(url, headers: headers, body: body);

  
  switch(response.statusCode ){
    case 200:
    case 201:
     return true;
      break;
    default:
     throw Exception('خرب');
      break;
   }
  }
 
  Future<List<Wishlist>> getWishlist()async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    // print(apiToken);
    int userId = sharedPreferences.getInt('user_id');
    // print(userId);
   String url = ApiUti.USER_PROFILE+userId.toString()+'/wishlist';
   // print(url);
   Map<String,String>headers = {
     'Accept' : 'application/json',
     'Authorization' : 'Bearer ' + apiToken
   };


    http.Response response = await http.get(url, headers:headers);
    // print(response.body);
    // print(response.body);
     List<Wishlist> wishlist =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
      //   print(body);
        for(var item in body['data']){
           wishlist.add(Wishlist.fromJson(item));
        }
        return wishlist;
     }
   return null;
  }

  Future<bool> deletWishlist(int id)async{

SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
String apiToken = sharedPreferences.get('api_token');
     Map<String,String> headers = {
     'Accept' : 'application/json',
     'Authorization' : 'Bearer ' + apiToken
};
    String url= ApiUti.WESHLIST +'/'+ id.toString();
print(url);
      http.Response response = await http.post(url, headers: headers);

  print(response.body);
  switch(response.statusCode ){
    case 200:
    case 201:
     return true;
      break;
    default:
     throw Exception('خرب');
      break;
  }
  }
}