import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //widget para criar um degrade na tela
    Widget _buildBodyBack() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        );

    return Stack(
      children: [
        _buildBodyBack(), //widget que esta deixando o fundo degrade
        CustomScrollView(
          //scroll view customizado
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('home')
                  .orderBy('pos')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  List listaImagens = snapshot.data!.docs.toList();
                  return SliverToBoxAdapter(
                    child: GridView.custom(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: snapshot.data!.docs.map((doc) {
                            return QuiltedGridTile(doc["x"], doc["y"]);
                          }).toList()),
                      childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) => FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: listaImagens[index]["image"]),
                          childCount: listaImagens.length),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
