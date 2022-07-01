import 'package:bill_desk/src/Configuration/Widgets/product_card.dart';

class Category{
  int id ;
  String name ;
  String image ;
  bool isSelected ;
  Category({ required this.id, required this.name,  this.isSelected = false, required this.image});
}
// Vertical Scroll
class AppData {
  static List<Product> productList = [
    Product(
        id: 1,
        name: 'I Phone 7',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/png/iphone_seven.png',
        category: "Trending Now",
 description: "Apple Product"),
    Product(
        id: 2,
        name: 'I Phone 13 Pro Max',
        price: 220.00,
        isliked: false,
        image:   "assets/png/iphone_thirteen.png",
        category: "Trending Now",
 description: "Apple Product"),
  ];
  static List<Product> cartList = [
    Product(
        id: 1,
        name: 'Macbook',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image:   "assets/png/macbook.png",
        category: "Trending Now",
 description: "Apple Product"),
   
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/small_tilt_shoe_2.png',
    //     category: "Trending Now",

  ];
  static List<Category> categoryList = [

  
    Category(id: 2, name: "Phones", image:   "assets/phone.jpeg",),
    Category(id: 3, name: "tablets", image:   "assets/phone.jpeg",),
    Category(id: 4, name: "laptops", image:   "assets/phone.jpeg",),
  ];
  static List<String> showThumbnailList = [
    "assets/phone.jpeg",
    "assets/phone.jpeg",
  "assets/phone.jpeg",
    "assets/phone.jpeg",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
