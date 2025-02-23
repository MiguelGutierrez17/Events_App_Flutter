import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/adventures_provider.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class AdventureCardAdd extends StatelessWidget {
  const AdventureCardAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return GestureDetector(
      onTap: () => {
        if (currentRoute == 'home')
          {
            adventuresProvider.currentAdventure = Adventure(
                title: '',
                date: DateTime.now().toString(),
                place: '',
                add: true),
            Navigator.pushNamed(context, 'details')
          }
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        padding: const EdgeInsets.all(0),
        color: Colors.grey,
        dashPattern: const [4],
        strokeWidth: 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: currentRoute == 'home' ? 180 : 200,
            child: const AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+',
                          style: TextStyle(fontSize: 55, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
