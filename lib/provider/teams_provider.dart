import 'dart:math';

import 'package:commanddelemiter/model/person.dart';
import 'package:flutter/material.dart';

class TeamsProvider extends ChangeNotifier {
  List<List<Person>> _teams;
  final _rnd;

  TeamsProvider()
      : _teams = [],
        _rnd = Random();

  List<List<Person>> get teams => _teams;

  void randomizeAndSet(List<Person> persons, int count, bool captains) {
    _teams = _generateCommands(persons, count, captains);
    notifyListeners();
  }

  void setTeams(List<List<Person>> teams) {
    _teams = teams;
    notifyListeners();
  }

  void clearAll() {
    _teams.clear();
    notifyListeners();
  }

  List<List<Person>> _generateCommands(List<Person> allPersons, int count, bool captains) {
    var persons = List<Person>.from(allPersons);
    var commands = <List<Person>>[];
    for (var i = 0; i < count; i++) commands.add(<Person>[]);
    var i = 0;
    while (persons.isNotEmpty) {
      var y = 0;
      while (y < count && persons.isNotEmpty) {
        final person = persons.removeAt(_rnd.nextInt(persons.length));
        commands[y].add(captains && i == 0 ? person.copyWith(captain: true) : person);
        y++;
      }
      i++;
    }
    return commands;
  }
}
