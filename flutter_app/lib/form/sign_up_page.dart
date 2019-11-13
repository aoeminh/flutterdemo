import 'package:flutter/material.dart';
import 'package:flutter_app/form/widget/text_field_signup.dart';
import 'package:intl/intl.dart';

class SignUppage extends StatefulWidget {
  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  Key key = GlobalKey<FormState>();
  String _name;
  TextEditingController dateController ;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký')),
      body: _buildBody(),
    );
  }

  _buildBody() => Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              //name
              children: <Widget>[
                TextFieldSignUp(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Tên',
                  onChange: (value) {
                    _name = value;
                  },
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Tên không được nhỏ hơn 6 ký tự';
                    } else {
                      return null;
                    }
                  },
                ),

                //date
                TextFieldSignUp(
                  inputController: dateController,
                  prefixIcon: Icon(Icons.date_range),
                  hintText: 'Ngày sinh',
                  inputType: TextInputType.datetime,
                  onClick: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime.now());
                    String s =
                        new DateFormat("dd/MM/yyyy").format(date);

                    setState(() {dateController.text =s;});
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
