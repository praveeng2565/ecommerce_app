import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'myCart.dart';
import 'product_details.dart';
import 'product_template.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51L6JEZSCH6mMoXL4ATvWYeJkMPF56bCJTbXrOfw6whWRkWly2qO2U2cFRhvP2Mqp5A25UaV0hWlFjgLjJyWhfEur00fVfRxpwC';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // Holds the products details(like cost, id, description, etc.,)
  late List<ProductDetails> products;

  @override
  void initState() {
    products = <ProductDetails>[
      ProductDetails(
          id: 111,
          brandName: 'Uniquo India',
          cost: 1960,
          imagePath: 'assets/shirt1.jpg',
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
      ProductDetails(
          id: 111,
          brandName: 'The House of Rare',
          cost: 1750,
          imagePath: 'assets/shirt2.jpg',
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
      ProductDetails(
          id: 111,
          brandName: 'Arrow',
          cost: 1499,
          imagePath: 'assets/shirt3.jpg',
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
      ProductDetails(
          id: 111,
          brandName: 'Peter England',
          cost: 2010,
          imagePath: 'assets/shirt1.jpg',
          isAddedToCart: true,
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
      ProductDetails(
          id: 111,
          brandName: 'Van Heusan',
          cost: 1870,
          imagePath: 'assets/shirt2.jpg',
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
      ProductDetails(
          id: 111,
          brandName: 'The House of Rare',
          cost: 1389,
          imagePath: 'assets/shirt3.jpg',
          description:
              'Solid Modal Linen fabric. Spread collar. Long buttoned sleeve. Button fastening on the front section.'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF3F5AA6),
            title: const Text('ECommerce Application'),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFF3F5AA6),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorPadding: const EdgeInsets.all(5.0),
              indicatorColor: Colors.blue,
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.collections), Text(' SHOP')],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_cart),
                      Text(' MY CART')
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Shows all products details in list view.
              Products(products: products),
              // Shows user selected product details with total cost in list view.
              MyCart(products: products)
            ],
          ),
        ),
      ),
    );
  }
}
