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
    return GestureDetector(
      // onTap: () =>
      //     Navigator.pushNamed(context, 'details', arguments: adventure),
      onTap: () {
        adventuresProvider.currentAdventure = adventure;
        Navigator.pushNamed(context, 'details');
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
                  child: adventure.img != null
                      ? Image.network(adventure.img!, fit: BoxFit.cover)
                      : Image.network('', fit: BoxFit.cover)),
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
            ],
          ),
        ),
      ),
    );
  }
}
