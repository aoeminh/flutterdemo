import 'package:flutter/material.dart';
import 'package:flutter_app/chat/message.dart';
import 'package:flutter_app/chat/text_style.dart';

import 'Util.dart';

const double maxWidthContent = 300;
class OwnerMessage extends StatelessWidget {
  OwnerMessage(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            Util.convertTimeToString(message.time),
            style: TextStyleUtil.textSecondaryGrey(),
          ),
          SizedBox(width: 5,),
          ConstrainedBox(
            constraints:  BoxConstraints(
              maxWidth: maxWidthContent,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.green),
              child: Text(message.content),

            ),

          ),
        ],
      ),
    );
  }
}
