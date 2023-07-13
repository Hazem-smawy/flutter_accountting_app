import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurencyShowWidget extends StatefulWidget {
  CurencyShowWidget({super.key});

  @override
  State<CurencyShowWidget> createState() => _CurencyShowWidgetState();
}

class _CurencyShowWidgetState extends State<CurencyShowWidget> {
  final list = ["دولار", "ريال", "محلي"];
  late String selected;
  @override
  void initState() {
    // TODO: implement initState
    selected = list.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.containerColor.withOpacity(0.5),
        // boxShadow: [
        //   BoxShadow(
        //     color: MyColors.shadowColor.withOpacity(0.09),
        //     offset: Offset(1, 0),
        //     //spreadRadius: 10,
        //     blurRadius: 10,
        //   )
        //]
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: list.map((element) {
            return CurencyShowItem(
                action: () {
                  setState(() {
                    selected = element;
                  });
                },
                isSelected: selected == element,
                lable: element);
          }).toList()),
    );
  }
}

class CurencyShowItem extends StatelessWidget {
  CurencyShowItem(
      {super.key,
      required this.action,
      required this.isSelected,
      required this.lable});
  VoidCallback action;
  final bool isSelected;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Row(
        children: [
          Text(
            lable,
            style: myTextStyles.body.copyWith(
              color: isSelected
                  ? MyColors.primaryColor
                  : MyColors.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(width: 5),
          FaIcon(
            isSelected ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
            size: 15,
            color: isSelected
                ? MyColors.primaryColor
                : MyColors.secondaryTextColor,
          )
        ],
      ),
    );
  }
}
