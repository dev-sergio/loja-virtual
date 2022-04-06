import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final ProductData product;

  @override
  State<StatefulWidget> createState() {
    return _ProductScreenState();
  }
}

class _ProductScreenState extends State<ProductScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String? size;

  @override
  Widget build(BuildContext context) {
    final ProductData product = widget.product;
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                aspectRatio: 1.15,
                autoPlay: false,
                enlargeCenterPage: true,
                //scrollDirection: Axis.vertical,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                    },
                  );
                },
              ),
              items: product.images
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 20.0,
                        ),
                        elevation: 6.0,
                        shadowColor: const Color.fromARGB(255, 82, 200, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: product.images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(entry.key);
                },
                child: Container(
                  width: _current == entry.key ? 12.0 : 9.0,
                  height: _current == entry.key ? 12.0 : 9.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : primaryColor)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((s) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            border: Border.all(
                                color: size != null && s == size
                                    ? primaryColor
                                    : const Color.fromARGB(255, 206, 206, 206),
                                width: 3.0),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: size != null ? () {} : null,
                    child: const Text(
                      "Adicionar ao carrinho",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(product.description, style: const TextStyle(fontSize: 16))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
