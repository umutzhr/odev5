import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ürün Listesi',
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: ProductPage(
        isDarkTheme: isDarkTheme,
        onThemeChanged: (bool value) {
          setState(() {
            isDarkTheme = value;
          });
        },
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  ProductPage({required this.isDarkTheme, required this.onThemeChanged});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Logitech MX Master 3 Mouse', 'price': 1500},
    {'name': 'Razer DeathAdder V2 Mouse', 'price': 1000},
    {'name': 'SteelSeries Apex Pro Klavye', 'price': 3500},
    {'name': 'Corsair K95 RGB Platinum Klavye', 'price': 4000},
    {'name': 'Logitech G Pro X Klavye', 'price': 2500},
    {'name': 'HyperX Alloy FPS Pro Klavye', 'price': 1500},
    {'name': 'Razer Huntsman Mini Klavye', 'price': 2000},
    {'name': 'Asus ROG Chakram Mouse', 'price': 2000},
  ];

  int? selectedProductIndex;

  void _onProductSelected(int index) {
    setState(() {
      selectedProductIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Listesi'),
        actions: [
          Row(
            children: [
              Text("Dark Theme"),
              Switch(
                value: widget.isDarkTheme,
                onChanged: widget.onThemeChanged,
              ),
            ],
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dikey ListView (Ürün Adları)
          Flexible(
            flex: 2,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onProductSelected(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: selectedProductIndex == index
                          ? Colors.blueAccent
                          : (isDarkMode ? Colors.grey[800] : Colors.grey[300]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        products[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedProductIndex == index
                              ? Colors.white
                              : (isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          // GridView (Ürün Adı ve Fiyatı)
          Expanded(
            flex: 5,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _onProductSelected(index),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedProductIndex == index
                          ? (isDarkMode ? Colors.blueGrey : Colors.lightBlue[100])
                          : (isDarkMode ? Colors.grey[850] : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: selectedProductIndex == index
                            ? Colors.blue
                            : (isDarkMode ? Colors.grey : Colors.grey),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          products[index]['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${products[index]['price']} ₺',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
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
    );
  }
}
