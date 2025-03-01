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
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 30,
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
              const SizedBox(height: 20),
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
    final adding = adventuresProvider.currentAdventure.add ?? false;
    return Form(
      key: _adventureKey,
      child: Column(
        children: [
          CustomField(
              fieldLabel: 'Title',
              hintLabel: 'Type your event title',
              initialValue:
                  adding ? '' : adventuresProvider.currentAdventure.title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
          CustomField(
              fieldLabel: 'Place',
              hintLabel: 'Select a date',
              initialValue:
                  adding ? '' : adventuresProvider.currentAdventure.date,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
          CustomField(
              fieldLabel: 'Place',
              hintLabel: 'Type place of adventure',
              initialValue:
                  adding ? '' : adventuresProvider.currentAdventure.place,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Place field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final String fieldLabel;
  final String hintLabel;
  final String? initialValue;
  final String? Function(String?)? validator;

  const CustomField(
      {super.key,
      required this.fieldLabel,
      required this.hintLabel,
      this.initialValue,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldLabel),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: initialValue,
            decoration: _FieldStyle.newStyle(placeholderText: hintLabel),
            validator: validator,
          )
        ],
      ),
    );
  }
}

class _FieldStyle {
  static InputDecoration newStyle({
    String placeholderText = "",
  }) {
    return InputDecoration(
      hintText: placeholderText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
