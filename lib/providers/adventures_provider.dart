import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/db_provider.dart';
import 'package:flutter/material.dart';

class AdventuresProvider extends ChangeNotifier {
  //Esto debería ser un servicio, consultar con la app de productos
  List<Adventure> adventures = [];
  late Adventure _currentAdventure;

  AdventuresProvider() {
    getAllAdventures();
  }

  Future createUpdateAdventure(Adventure adventure) async {
    // isSaving = true;
    // notifyListeners();
    if (adventure.id == null) {
      await newAdventure(adventure);
    } else {
      await updateAdventure(adventure);
    }
    // isSaving = false;
    notifyListeners();
  }

  Future<int> newAdventure(Adventure createRequest) async {
    final newAdventure = Adventure(
        img: createRequest.img,
        title: createRequest.title,
        date: createRequest.date,
        place: createRequest.place);
    final id = await DBProvider.db.newAdventure(createRequest);
    newAdventure.id = id;
    adventures.add(newAdventure);
    notifyListeners();
    return id;
  }

  Future<int> updateAdventure(Adventure updateRequest) async {
    await DBProvider.db.updateAdventure(updateRequest);
    final index = adventures.indexWhere((x) => x.id == updateRequest.id);
    adventures[index] = updateRequest;
    notifyListeners();
    return updateRequest.id!;
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
