import 'dart:math';

import 'package:commanddelemiter/model/person.dart';
import 'package:commanddelemiter/pages/teams/components/team_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamsProvider extends ChangeNotifier {
  List<List<Person>> _teams;
  final _rnd;

  TeamsProvider()
      : _teams = [],
        _rnd = Random();

  List<List<Person>> get teams => _teams;

  List<Widget> get teamsWidgets {
    if (teams.isEmpty) return <Column>[];
    final columns = <Widget>[SizedBox(height: 6.w)];
    var i = 1;
    teams.forEach((team) {
      var itemList = <TeamItem>[];
      itemList.add(TeamItem(text: 'Team $i'));
      team.forEach((person) {
        itemList.add(TeamItem(person: person));
      });
      columns.add(Column(children: itemList));
      i++;
    });
    return columns;
  }

  bool get isEmpty => _teams.isEmpty;

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
