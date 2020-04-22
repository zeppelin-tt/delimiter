import 'package:commanddelemiter/provider/teams_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamsProvider = Provider.of<TeamsProvider>(context);
    return Material(
      color: Colors.black,
      child: teamsProvider.isEmpty ? _EmptyTeamsView() : ListView(children: teamsProvider.teamsWidgets),
    );
  }
}

class _EmptyTeamsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/skull.svg',
            color: Colors.grey[900],
            height: 400.0.h,
          ),
          Text('No teams yet', style: TextStyle(color: Colors.grey[900], fontSize: 42.0.sp))
        ],
      ),
    );
  }
}
