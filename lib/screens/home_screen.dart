import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/products_tab.dart';

import '../tabs/home_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      //Criar um esquema de layout para paginas
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      //Tira o scrollar pro lado que o pageview cria pro padrão
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const ProductsTab(),
        ),
        Container(
          color: const Color.fromARGB(255, 0, 26, 255),
        ),
        Container(
          color: const Color.fromARGB(255, 192, 77, 245),
        ),
      ],
    );
  }
}
