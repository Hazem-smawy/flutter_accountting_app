import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorShowWidget extends StatelessWidget {
  const ErrorShowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "there is some eror",
            textAlign: TextAlign.right,
            style: myTextStyles.body.copyWith(color: Colors.red),
          ),
          SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
