import 'dart:convert';

import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/adventures_provider.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdventureCard extends StatelessWidget {
  final Adventure adventure;

  const AdventureCard({super.key, required this.adventure});

  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return GestureDetector(
      onTap: () {
        if (currentRoute == 'home') {
          adventuresProvider.currentAdventure = adventure;
          Navigator.pushNamed(context, 'details');
        } else {
          print('image edit');
        }
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                    tag: adventure.id.toString(),
                    child: adventure.img != null
                        // ? Image.network(adventure.img!, fit: BoxFit.cover)
                        ? Image.memory(base64Decode(adventure.img!), fit: BoxFit.cover)
                        : Image.asset('assets/empty-state.jpg')),
              ),
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.5)
                    ])),
              )),
              Positioned(
                  bottom: 50,
                  right: 10,
                  child: Text(adventure.title,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20))),
              Positioned(
                bottom: 30,
                right: 10,
                // child: Text(
                //     DateFormat('dd/MM/yyyy HH:mm').format(adventure.date).toString(),
                child: Text(adventure.date,
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text(adventure.place,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Text(adventure.id.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
            ],
          ),
        ),
      ),
    );
  }
}
