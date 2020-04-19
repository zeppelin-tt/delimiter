import 'package:commanddelemiter/model/person.dart';
import 'package:commanddelemiter/pages/main/components/implicitly_animated_names_list.dart';
import 'package:commanddelemiter/pages/main/components/names_list_item.dart';
import 'package:commanddelemiter/provider/input_data_provider.dart';
import 'package:commanddelemiter/provider/teams_provider.dart';
import 'package:commanddelemiter/utils/locator.dart';
import 'package:commanddelemiter/utils/notifications.dart';
import 'package:commanddelemiter/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _maxHeight;
  double _maxWidth;
  double _distanceBetween;
  double _inputHeight;
  double _borderRadius;

  final _inputController = TextEditingController();
  final _scrollController = ScrollController(initialScrollOffset: 0);
  final _pageController = PageController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _inputDataProvider = Provider.of<InputDataProvider>(context);
    final _teamsProvider = Provider.of<TeamsProvider>(context);

    _onAddName() {
      _inputDataProvider.validateName(
        name: _inputController.text,
        onEmpty: () {},
        onExist: () => Notifications.error(context, 'this name is already in the list', _distanceBetween, _borderRadius),
        onSuccess: () {
          _inputDataProvider.addName(_inputController.text);
          _inputController.clear();
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOut,
            );
          }
        },
      );
    }

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        _maxHeight = constraints.biggest.height;
        _maxWidth = constraints.biggest.width;
        _distanceBetween = _maxWidth * .035;
        _inputHeight = _maxHeight * .06;
        _borderRadius = _maxWidth * .015;
        return PageView(
          controller: _pageController,
          children: <Widget>[
            GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                backgroundColor: Colors.grey[900],
                body: Column(
                  children: <Widget>[
                    SizedBox(height: _distanceBetween / 2),
                    Expanded(
                      child: ImplicitlyAnimatedNamesList(
                        separatorSize: _distanceBetween,
                        itemHeight: _inputHeight,
                        borderRadius: _borderRadius,
                        names: _inputDataProvider.persons,
                        scrollController: _scrollController,
                        onDelete: (person) => _inputDataProvider.deletePerson(person),
                      ),
                    ),
                    SizedBox(height: _distanceBetween / 2),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: _distanceBetween),
                      height: _inputHeight * 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('number of teams', style: TextStyle(color: Colors.white70)),
                              Theme(
                                data: ThemeData(
                                  textTheme: Theme.of(context).textTheme.copyWith(body1: TextStyle(color: Colors.white24)),
                                  accentColor: Color(0xff2ca5e0),
                                ),
                                child: SizedBox(
                                  height: _inputHeight,
                                  child: NumberPicker.horizontal(
                                    itemExtent: _maxWidth * .09,
                                    initialValue: _inputDataProvider.countTeams,
                                    minValue: 1,
                                    maxValue: 12,
                                    onChanged: (count) => _inputDataProvider.setCountTeams(count),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('with captains', style: TextStyle(color: Colors.white70)),
                              CupertinoSwitch(
                                activeColor: Color(0xff2ca5e0),
//                                trackColor: Colors.white24,
                                value: _inputDataProvider.captains,
                                onChanged: (bool value) => _inputDataProvider.setCaptains(value),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            child: SizedBox(
                              height: double.infinity,
                              width: _maxWidth * 0.245,
                              child: FlatButton(
                                color: Color(0xff2ca5e0),
                                onPressed: () {
                                  if (_inputDataProvider.completedTeams) {
                                    _teamsProvider.randomizeAndSet(_inputDataProvider.persons, _inputDataProvider.countTeams, _inputDataProvider.captains);
                                    if (_pageController.hasClients) {
                                      _pageController.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeInOut);
                                    }
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  } else {
                                    Notifications.error(context, 'teams are not completed', _distanceBetween, _borderRadius);
                                  }
                                },
                                child: Text('Generate', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: _distanceBetween),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: _distanceBetween),
                      height: _inputHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: double.infinity,
                            width: _maxWidth - _maxWidth * 0.245 - _distanceBetween * 3,
                            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(_borderRadius)),
                            child: TextField(
                              style: TextStyle(color: Colors.white70),
                              controller: _inputController,
                              onSubmitted: (_) {
                                _onAddName();
                                FocusScope.of(context).requestFocus(_focusNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Enter name',
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                            ),
                          ),
                          SizedBox(height: _distanceBetween),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            child: SizedBox(
                              height: double.infinity,
                              width: _maxWidth * 0.245,
                              child: FlatButton(
                                color: Color(0xff2ca5e0),
                                onPressed: () {
                                  print("persons: ${locator<Storage>().persons}");
                                  return _onAddName();
                                },
                                child: Text('Add', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: _distanceBetween),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.black,
              child: ListView(
                children: buildTeamList(
                  teams: _teamsProvider.teams,
                  borderRadius: _borderRadius,
                  itemHeight: _inputHeight,
                  separatorSize: _distanceBetween,
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

List<Column> buildTeamList({List<List<Person>> teams, double itemHeight, double separatorSize, double borderRadius}) {
  if (teams.isEmpty) return <Column>[];
  final columns = <Column>[];
  var i = 1;
  teams.forEach((team) {
    var itemList = <PersonItem>[];
    itemList.add(PersonItem(height: itemHeight, text: 'Team $i', borderRadius: borderRadius, separatorSize: separatorSize));
    team.forEach((person) {
      itemList.add(PersonItem(height: itemHeight, person: person, borderRadius: borderRadius, separatorSize: separatorSize));
    });
    columns.add(Column(children: itemList));
    i++;
  });
  return columns;
}
