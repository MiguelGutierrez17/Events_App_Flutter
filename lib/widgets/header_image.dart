import 'package:adventures_app/models/adventure.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final Adventure adventure;

  const HeaderImage({super.key, required this.adventure});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: AspectRatio(
          aspectRatio: 16 / 9,
          child: (adventure.add != null && adventure.add == true) ||
                  adventure.img == null
              ? Image.asset('assets/empty-state.jpg', fit: BoxFit.cover)
              : Image.network(adventure.img!, fit: BoxFit.cover)),
    );
  }
}
