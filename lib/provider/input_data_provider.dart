import 'package:commanddelemiter/model/person.dart';
import 'package:commanddelemiter/utils/locator.dart';
import 'package:commanddelemiter/utils/storage.dart';
import 'package:flutter/material.dart';

class InputDataProvider extends ChangeNotifier {
  List<Person> _persons;
  int _countTeams;
  bool _captains;

  InputDataProvider()
      : _persons = [],
        _countTeams = 2,
        _captains = true;

  Future<void> init() async {
    await locator.allReady();
    _getAll();
  }

  void _getAll() {
    _countTeams = locator<Storage>().countTeams;
    _captains = locator<Storage>().captains;
    _persons = locator<Storage>().persons;
    notifyListeners();
  }

  List<Person> get persons => _persons;

  int get countTeams => _countTeams;

  bool get captains => _captains;

  bool get completedTeams => _persons.length >= _countTeams;

  void validateName({
    String name,
    Function() onEmpty,
    Function() onExist,
    Function() onSuccess,
  }) {
    if (name == null || name.isEmpty) return onEmpty();
    if (_persons.contains(Person(name))) return onExist();
    return onSuccess();
  }

  void addName(String name) {
    _persons.add(Person(name));
    locator<Storage>().setPersons(_persons);
    notifyListeners();
  }

  void setPersons(List<Person> persons) {
    _persons = persons;
    locator<Storage>().setPersons(_persons);
    notifyListeners();
  }

  void clearPersons() {
    _persons.clear();
    locator<Storage>().clearPersons();
    notifyListeners();
  }

  void deletePerson(Person person) {
    _persons.remove(person);
    locator<Storage>().setPersons(_persons);
    notifyListeners();
  }

  void setCountTeams(int count) {
    _countTeams = count;
    locator<Storage>().setCountTeams(_countTeams);
    notifyListeners();
  }

  void setCaptains(bool value) {
    _captains = value;
    locator<Storage>().setCaptains(_captains);
    notifyListeners();
  }
}
