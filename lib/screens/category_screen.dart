import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, required this.snapshot}) : super(key: key);
  final DocumentSnapshot snapshot;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot["title"]),
          centerTitle: true,
          bottom: const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              icon: Icon(Icons.grid_on),
            ),
            Tab(icon: Icon(Icons.list))
          ]),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc(snapshot.id)
              .collection("items")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.65),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        type: "grid",
                        product: ProductData.fromDocument(
                            snapshot.data!.docs[index]),
                      );
                    },
                  ),
                  Scrollbar(
                    controller: _pageController,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          type: "list",
                          product: ProductData.fromDocument(
                              snapshot.data!.docs[index]),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
