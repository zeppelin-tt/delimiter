import 'package:commanddelemiter/model/person.dart';
import 'package:commanddelemiter/pages/main/components/item_transitions.dart';
import 'package:commanddelemiter/pages/main/components/team_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class ImplicitlyAnimatedNamesList extends StatelessWidget {
  final List<Person> names;
  final double separatorSize;
  final double itemHeight;
  final double borderRadius;
  final ValueChanged<Person> onDelete;
  final ScrollController scrollController;

  ImplicitlyAnimatedNamesList({
    @required this.names,
    @required this.separatorSize,
    @required this.itemHeight,
    @required this.borderRadius,
    @required this.onDelete,
    @required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedList(
      controller: scrollController,
      items: names,
      areItemsTheSame: (Person oldItem, Person newItem) => oldItem == newItem,
      removeItemBuilder: (context, animation, person) {
        return ItemTransitions(
          animation: animation,
          slideSide: -1.0,
          child: TeamListItem(
            separatorSize: separatorSize,
            borderRadius: borderRadius,
            person: person,
            height: itemHeight,
            onDelete: (person) => onDelete(person),
          ),
        );
      },
      itemBuilder: (context, animation, person, index) {
        return ItemTransitions(
          animation: animation,
          slideSide: 1.0,
          child: TeamListItem(
            separatorSize: separatorSize,
            borderRadius: borderRadius,
            person: person,
            height: itemHeight,
            onDelete: (person) => onDelete(person),
          ),
        );
      },
    );
  }
}
