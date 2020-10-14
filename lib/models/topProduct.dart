
class TopProduct{
  int product_id;
  String product_title,product_description;
  double product_price,product_total;
 
  List<String> images;

  TopProduct(this.product_id,this.product_description,this.images,
  this.product_price,this.product_title, this.product_total,);

  TopProduct.fromJson(Map<String,dynamic> jsonObject){
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.product_price = double.tryParse(jsonObject['product_price']);
    
    

   this.images =[];
   if(jsonObject['product_images'] != null){
     _setImages(jsonObject['product_images']);
   }
  }

  void _setImages(List<dynamic> jsonImages){
  images =[];
   if(jsonImages.length > 0){
      for(var image in jsonImages){
        if(image != null){
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featureImage(){
    if(this.images.length > 0){
    return this.images[0];
    }
    return 'https://picjumbo.com/wp-content/uploads/sunset-ocean-free-photo-DSC04212-1080x720.jpg';
  }
}