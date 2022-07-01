import 'package:bill_desk/src/Themes/light_color.dart';
import 'package:flutter/material.dart';

class Product{
  int id;
  String name ;
  String category ;
    String description ;
  String image ;
  double price ;
  bool isliked ;
  bool isSelected ;
  Product({required this.id,required this.name,required this.description, required this.category, required this.price, required this.isliked,this.isSelected = false, required this.image});
}

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  const ProductCard({ Key ? key, required this.product, required this.onSelected}) : super(key: key);

//   @overri?
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                  product.isliked ? Icons.favorite : Icons.favorite_border,
                  color:
                      product.isliked ? LightColor.red : LightColor.iconColor,
                ),
                onPressed: () {},
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: product.isSelected ? 15 : 0),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: LightColor.orange.withAlpha(40),
                      ),
                      Image.asset(product.image)
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                Text(
               product.name,
               
                ),
                  Text(
               product.category,
               
                ),
                  Text(
               product.price.toString(),
               
                ),
             
              ],
            ),
          ],
        ),
      )
    );
  }
}
