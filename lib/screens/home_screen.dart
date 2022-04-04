import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView( //Criar um esquema de layout para paginas
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), //Tira o scrollar pro lado que o pageview cria pro padrão
      children: const [
        HomeTab(),
      ],
    );
  }
}
