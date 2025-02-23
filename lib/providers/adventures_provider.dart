import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/db_provider.dart';
import 'package:flutter/material.dart';

class AdventuresProvider extends ChangeNotifier {
  List<Adventure> adventures = [];
  late Adventure _currentAdventure;

  Future<Adventure> newAdventure(Adventure createRequest) async {
    final newAdventure = Adventure(
        img: createRequest.img,
        title: createRequest.title,
        date: createRequest.date,
        place: createRequest.date);
    final id = await DBProvider.db.newAdventure(createRequest);
    newAdventure.id = id;
    adventures.add(newAdventure);
    notifyListeners();
    return newAdventure;
  }

  getAllAdventures() async {
    final adventuresInter = await DBProvider.db.getAllAdventures();
    if (adventuresInter.isNotEmpty) {
      adventures = [...adventuresInter];
    }
    notifyListeners();
  }

  deleteAdventureById(int id) async {
    await DBProvider.db.deleteAdventureById(id);
    notifyListeners();
  }

  Adventure get currentAdventure {
    return _currentAdventure;
  }

  set currentAdventure(Adventure adventure) {
    _currentAdventure = adventure;
    notifyListeners();
  }
}
