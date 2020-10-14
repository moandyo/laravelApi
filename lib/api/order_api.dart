import 'package:http/http.dart' as http;

import 'package:fluttershop/api/api_utilty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi{

  Future<bool> addOrder(int userID, int productID)async{
   
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
String apiToken = sharedPreferences.get('api_token');

   String url = ApiUti.ORDER ;
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
}