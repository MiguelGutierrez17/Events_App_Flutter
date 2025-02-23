import 'package:adventures_app/widgets/card_adventure_add.dart';
import 'package:adventures_app/widgets/header_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/adventures_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final Adventure adventure = ModalRoute.of(context)!.settings.arguments as Adventure;
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    final currentAdventure = adventuresProvider.currentAdventure;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'home'),
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              currentAdventure.add == true 
              ? const AdventureCardAdd()
              : HeaderImage(adventure: currentAdventure),
              const SizedBox(height: 10),
              const MyForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _adventureKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    final adding =
        adventuresProvider.currentAdventure.add == true ? true : false;
    return Form(
      key: _adventureKey,
      child: Column(
        children: [
          TextFormField(
                        decoration: const InputDecoration(
              labelText: 'Title'
            ),
            initialValue:
                adding ? '' : adventuresProvider.currentAdventure.title,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title field is missing';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date'
            ),
            initialValue:
                adding ? '' : adventuresProvider.currentAdventure.date,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Date field is missing';
              }
              return null;
            },
          ),
          TextFormField(
                        decoration: const InputDecoration(
              labelText: 'Place'
            ),
            initialValue:
                adding ? '' : adventuresProvider.currentAdventure.place,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Place field is missing';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
