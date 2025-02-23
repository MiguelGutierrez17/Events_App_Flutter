import 'package:adventures_app/models/adventure.dart';
import 'package:flutter/material.dart';

class AdventuresFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Adventure adventure;
  AdventuresFormProvider(this.adventure);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
