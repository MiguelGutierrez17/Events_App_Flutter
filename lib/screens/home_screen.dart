import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/adventures_provider.dart';
import 'package:adventures_app/widgets/card_adventure.dart';
import 'package:adventures_app/widgets/card_adventure_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adventuresServices = Provider.of<AdventuresProvider>(context);
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
                  itemCount: adventuresServices.adventures.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          child: AdventureCard(
                              adventure: adventuresServices.adventures[index])),
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
