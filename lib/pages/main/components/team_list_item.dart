import 'package:commanddelemiter/model/person.dart';
import 'package:flutter/material.dart';

class TeamListItem extends StatelessWidget {
  final double height;
  final double separatorSize;
  final double borderRadius;
  final Person person;
  final ValueChanged<Person> onDelete;

  TeamListItem({
    @required this.height,
    @required this.separatorSize,
    @required this.borderRadius,
    @required this.person,
    @required this.onDelete,
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
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(person.name, style: TextStyle(color: Colors.white, fontSize: 22.0)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
              borderRadius: BorderRadius.circular(height / 2),
              radius: height / 2,
              splashColor: Colors.transparent,
              onTap: () => onDelete(person),
              child: Icon(Icons.clear, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}