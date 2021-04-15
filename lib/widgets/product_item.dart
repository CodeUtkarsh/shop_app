import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white24,
          leading: Consumer<Product>(
            //Similar to product of
            //Advantage is that if we have sub widgets that are only affected by a
            //change we can use consumer for the things that do change
            //Now only this changes as it calls the listener
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Colors.red,
            ),
            //child: Text('Never changes!'),
            //This child is something that shouldn't rebuild insde the consumer build
            //like we had a label here of favourite that is something that sholudn't change
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            color: Colors.black,
          ),
        ),
      ),
    );
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: GridTile(
    //     child: GestureDetector(
    //       onTap: () {
    //         Navigator.of(context).pushNamed(
    //           ProductDetailScreen.routeName,
    //           arguments: product.id,
    //         );
    //       },
    //       child: Image.network(
    //         product.imageUrl,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     footer: GridTileBar(
    //       backgroundColor: Colors.white24,
    //       leading: IconButton(
    //         icon: Icon(
    //           product.isFavourite ? Icons.favorite : Icons.favorite_border,
    //         ),
    //         onPressed: () {
    //           product.toggleFavoriteStatus();
    //         },
    //         color: Colors.red,
    //       ),
    //       title: Text(
    //         product.title,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //       ),
    //       trailing: IconButton(
    //         icon: Icon(Icons.shopping_cart_outlined),
    //         onPressed: () {},
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //  );
  }
}
