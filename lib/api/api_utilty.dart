class ApiUti {
//teblink
 static const String MAIN_API_URL  = 'http://192.168.1.104:9000/api/';

//RR
 //static const String MAIN_API_URL  = 'http://192.168.1.106:9000/api/';

 static const String AUTH_REGISTER = MAIN_API_URL+'auth/register';
 
 static const String AUTH_LOGEN    = MAIN_API_URL+'auth/login';

 static const String PRODUCTS      = MAIN_API_URL + 'product';


static const String PRODUCTStype      = MAIN_API_URL + 'productsType/';
static const String PRODUCTStag      = MAIN_API_URL + 'productsTag/';


 static const String TOPPRODUCTS      = MAIN_API_URL + 'topProduct';

  static const String ORDER      = MAIN_API_URL + 'order';
  
  static const String WESHLIST      = MAIN_API_URL + 'wishlist';

  static const String SEARCH      = MAIN_API_URL + 'search';

  static const String USER_PROFILE      = MAIN_API_URL + 'user/';

 
 static  String CATEGORY_PRODUCTS(int id , int page){
  return MAIN_API_URL + 'category/' + id.toString() + '/products?page=' + page.toString();
 }

 static const String CATEGORIES    = MAIN_API_URL + 'category';
}