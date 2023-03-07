import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // package for making API calls

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  bool _isLoading = false;

  // method to fetch products from API
  Future<void> _getProducts() async {
    setState(() {
      _isLoading = true;
    });

    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      setState(() {
        products = decoded;
      });
    } else {
      print('Error fetching products');
    }
  }

  // method to toggle favorite icon
  void _toggleFavorite(int index) {
    setState(() {
      products[index]['isFavorite'] = !(products[index]['isFavorite'] ?? false);
    });
  }

  // method to build rating stars
  Widget _buildRatingStars(int count) {
    List<Widget> stars = [];
    for (int i = 0; i < count; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: 18));
    }
    return Row(children: stars);
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          // search bar

          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _getProducts,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  const Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Text(
                      'Special offers',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'The best',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              // TODO: Implement product detail screen
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                        products[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: SizedBox(
                                      height: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[index]['title'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              _buildRatingStars(
                                                products[index]['rating']
                                                        ['rate']
                                                    .round(),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '(${products[index]['rating']['count']})',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${products[index]['price']}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _toggleFavorite(index);
                                                },
                                                icon: Icon(
                                                  products[index]
                                                              ['isFavorite'] ==
                                                          true
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: products[index]
                                                              ['isFavorite'] ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement cart screen
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
