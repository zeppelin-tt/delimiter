import 'package:commanddelemiter/model/person.dart';
import 'package:flutter/material.dart';

class PersonItem extends StatelessWidget {
  final double height;
  final double separatorSize;
  final double borderRadius;
  final Person person;
  final String text;

  PersonItem({
    @required this.height,
    @required this.separatorSize,
    @required this.borderRadius,
    this.person,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: separatorSize, vertical: separatorSize / 2),
      padding: EdgeInsets.symmetric(horizontal: separatorSize),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: person == null ? Colors.transparent : Color(0xff2ca5e0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          person == null
              ? Text(text, style: TextStyle(color: Colors.white70, fontSize: 22.0))
              : Text(person.name, style: TextStyle(color: Colors.black, fontSize: 22.0)),
          if (person != null && person.captain) Icon(Icons.star, color: Colors.black),
        ],
      ),
    );
  }
}
