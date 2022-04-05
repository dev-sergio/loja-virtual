import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  const DrawerTiles(
      {Key? key,
      required this.icon,
      required this.text,
      required this.pageController,
      required this.page})
      : super(key: key);

  final int page;
  final IconData icon;
  final String text;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(children: [
            Icon(icon,
                size: 32,
                color: pageController.page!.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700]),
            const SizedBox(
              width: 32,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: pageController.page!.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700]),
            )
          ]),
        ),
      ),
    );
  }
}
