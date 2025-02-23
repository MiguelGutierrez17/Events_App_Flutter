import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/widgets/card_adventure.dart';
import 'package:adventures_app/widgets/card_adventure_add.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New event',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              const AdventureCardAdd(),
              const SizedBox(height: 20),
              const Text(
                'My events',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: AdventureCard(
                          adventure: Adventure(
                              add: false,
                              img:
                                  'https://ew.com/thmb/an0WhVkD3MKsX8CAC32_OdfOl94=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Dune-Part-Two-Trailer-062923-10-06744c94e3784ea696b5f79e736f1730.jpg',
                              place: 'Home',
                              title: 'Dune: Part Two',
                              date: DateTime.now().toString()),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
