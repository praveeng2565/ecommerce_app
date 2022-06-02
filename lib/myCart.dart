import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

import 'product_details.dart';

// Shows user selected product details with total cost in list view.
class MyCart extends StatefulWidget {
  const MyCart({Key? key, required this.products}) : super(key: key);
  final List<ProductDetails> products;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  // Convertion of double numbers into indian rupees currency format.
  final NumberFormat indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    symbol: '₹ ',
  );

  // Returns a card with selected product image, brand name and cost.
  Widget _getCartDetails(ProductDetails details) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Image.asset(
                  details.imagePath,
                  width: 25,
                  height: 25,
                ),
              ),
              Expanded(flex: 2, child: Text(details.brandName)),
              Flexible(
                child: Text(
                  indianRupeesFormat.format(details.cost),
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
    double totalCost = 0;
    List<ProductDetails> myCartList = <ProductDetails>[];
    for (ProductDetails element in widget.products) {
      if (element.isAddedToCart) {
        myCartList.add(element);
        totalCost += element.cost;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 5,
          child: ListView.builder(
              itemCount: myCartList.length,
              itemBuilder: (BuildContext context, int index) {
                return _getCartDetails(myCartList[index]);
              }),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Total cost.
              Text(
                'Total: ${indianRupeesFormat.format(totalCost)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18),
              ),
              // Payment.
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const stripe.CardField(),
                        TextButton(
                          onPressed: () async {
                            await stripe.Stripe.instance.createPaymentMethod(
                                const stripe.PaymentMethodParams.card(
                                    paymentMethodData:
                                        stripe.PaymentMethodData()));
                          },
                          child: const Text('Proceed'),
                        )
                      ],
                    ),
                  ));
                },
                icon: const Icon(Icons.payment),
                label: const Text(
                  'PAY NOW',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
