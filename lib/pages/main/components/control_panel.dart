import 'package:commanddelemiter/pages/main/components/implicitly_animated_names_list.dart';
import 'package:commanddelemiter/provider/input_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ControlPanel extends StatelessWidget {
  final VoidCallback onAddName;
  final VoidCallback onGenerate;
  final ScrollController scrollController;
  final TextEditingController inputController;
  final FocusNode focusNode;

  ControlPanel({
    @required this.onAddName,
    @required this.onGenerate,
    @required this.scrollController,
    @required this.inputController,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    num _itemWidth = (400 - 12 * 4) / 3;
    final inputDataProvider = Provider.of<InputDataProvider>(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 6.w),
        Expanded(
          child: ImplicitlyAnimatedNamesList(
            separatorSize: 12.w,
            borderRadius: 6.w,
            names: inputDataProvider.persons,
            scrollController: scrollController,
            onDelete: (person) => inputDataProvider.deletePerson(person),
          ),
        ),
        SizedBox(height: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: (42 * 1.6).h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _itemWidth.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.w), border: Border.all(color: Colors.white24, width: 1.5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 4.h),
                    Text('number of teams', style: TextStyle(color: Colors.white70)),
                    Spacer(),
                    Theme(
                      data: ThemeData(
                        textTheme: Theme.of(context).textTheme.copyWith(body1: TextStyle(color: Colors.white24)),
                        accentColor: Color(0xff2ca5e0),
                      ),
                      child: SizedBox(
                        height: 42.h,
                        child: NumberPicker.horizontal(
                          itemExtent: 38.8.w,
                          initialValue: inputDataProvider.countTeams,
                          minValue: 1,
                          maxValue: 12,
                          onChanged: (count) => inputDataProvider.setCountTeams(count),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: _itemWidth.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.w), border: Border.all(color: Colors.white24, width: 1.5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 4.h),
                    Text('with captains', style: TextStyle(color: Colors.white70)),
                    Spacer(),
                    CupertinoSwitch(
                      activeColor: Color(0xff2ca5e0),
//                                trackColor: Colors.white24,
                      value: inputDataProvider.captains,
                      onChanged: (bool value) => inputDataProvider.setCaptains(value),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: SizedBox(
                  height: double.infinity,
                  width: _itemWidth.w,
                  child: FlatButton(
                    color: Color(0xff2ca5e0),
                    onPressed: onGenerate,
                    child: Text('Generate', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 42.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: (400 - _itemWidth - 12 * 3).w,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6.w)),
                child: TextField(
                  style: TextStyle(color: Colors.white70),
                  controller: inputController,
                  onSubmitted: (_) {
                    onAddName();
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Enter name',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                ),
              ),
              SizedBox(height: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: SizedBox(
                  height: double.infinity,
                  width: _itemWidth.w,
                  child: FlatButton(
                    color: Color(0xff2ca5e0),
                    onPressed: onAddName,
                    child: Text('Add', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0.sp)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.w),
      ],
    );
  }
}
