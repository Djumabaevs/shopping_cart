import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/cart_controller.dart';
import '/controllers/product_controller.dart';
import '/screens/cart_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/badge.dart';
import '/widgets/productgrid.dart';

enum FilterOptions {
  FAVOURITES,
  ALL,
}

class ProductOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _showOnlyFavourites = false;
    final controller = Get.put(ProductController());
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          GetBuilder<ProductController>(
              init: ProductController(),
              builder: (context) {
                return PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (FilterOptions selectedValue) {
                      if (selectedValue == FilterOptions.FAVOURITES) {
                        _showOnlyFavourites = true;
                        print(_showOnlyFavourites);
                      } else {
                        _showOnlyFavourites = false;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Text("Only Favourites"),
                            value: FilterOptions.FAVOURITES,
                          ),
                          PopupMenuItem(
                            child: Text("Show All"),
                            value: FilterOptions.ALL,
                          )
                        ]);
              }),
          GetBuilder<CartController>(
              init: CartController(),
              builder: (contex) {
                return Badge(
                  child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                      onPressed: () {
                        Get.to(() => CartScreen());
                      }),
                  value: cartController.itemCount.toString(),
                  color: Theme.of(context).accentColor,
                );
              })
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
