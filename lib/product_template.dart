import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'product_details.dart';

// Shows all products details in list view.
class Products extends StatefulWidget {
  const Products({Key? key, required this.products}) : super(key: key);
  final List<ProductDetails> products;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // Convertion of double numbers into indian rupees currency format.
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 1,
    symbol: '₹ ',
  );

  // Returns a card with product image, descrption and cost.
  Widget _getProductCard(ProductDetails details) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(
                  details.imagePath,
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mens Shirt',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        details.description,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      indianRupeesFormat.format(details.cost),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        details.isAddedToCart = !details.isAddedToCart;
                        setState(() {});
                      },
                      icon: Icon(
                        details.isAddedToCart
                            ? Icons.remove_shopping_cart
                            : Icons.shopping_cart,
                        color: details.isAddedToCart ? Colors.red : Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int length = widget.products.length;
    return ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          return _getProductCard(widget.products[index]);
        });
  }
}
