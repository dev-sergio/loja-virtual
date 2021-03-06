import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 25,
                      left: 0,
                      child: Text(
                        "Loja virtual",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn()
                                      ? "Entre ou cadastre-se >"
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  } else {
                                    model.signOut();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTiles(
                icon: Icons.home,
                text: "Início",
                pageController: pageController,
                page: 0,
              ),
              DrawerTiles(
                icon: Icons.list,
                text: "Produtos",
                pageController: pageController,
                page: 1,
              ),
              DrawerTiles(
                icon: Icons.location_on,
                text: "Lojas",
                pageController: pageController,
                page: 2,
              ),
              DrawerTiles(
                icon: Icons.playlist_add_check,
                text: "Meus Pedidos",
                pageController: pageController,
                page: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
