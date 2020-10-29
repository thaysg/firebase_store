import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_store/models/section.dart';
import 'package:flutter/cupertino.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  void addSection(Section section) {
    _editingSection.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSection.remove(section);
    notifyListeners();
  }

  final List<Section> _sections = [];

  //Clonando Sessão
  List<Section> _editingSection = [];
  //Clonando Sessão

  bool editing = false;

  Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Section> get sections {
    if (editing) {
      return _editingSection;
    } else {
      return _sections;
    }
  }

  //Entrar no modo de Edição
  void enterEditing() {
    editing = true;

    _editingSection = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  void saveEditing() {
    //editing = false;
    //SnotifyListeners();
    bool valid = true;
    for (final section in _editingSection) {
      if (!section.valid()) valid = false;
    }

    if (!valid) return;

    print('Salvar');

    //editing = false;
    //notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}
