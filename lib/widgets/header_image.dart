import 'dart:convert';
import 'package:adventures_app/models/adventure.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final Adventure adventure;

  const HeaderImage({super.key, required this.adventure});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('uwu');
      },
      child: Hero(
        tag: adventure.add == true ? 'add' : adventure.id.toString(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.hardEdge,
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: (adventure.add != null && adventure.add == true) ||
                      adventure.img == null
                  ? Image.asset('assets/empty-state.jpg', fit: BoxFit.cover)
                  : Image.memory(base64Decode(adventure.img!),
                      fit: BoxFit.cover)
              // : Image.network(adventure.img!, fit: BoxFit.cover)),
              ),
        ),
      ),
    );
  }
}
