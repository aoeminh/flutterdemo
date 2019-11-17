import 'package:flutter/material.dart';
import 'package:flutter_app/common_widget/common_text_form_field.dart';
import 'package:intl/intl.dart';

class SignUppage extends StatefulWidget {
  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  final key = GlobalKey<FormState>();
  String _name;
  String _email;
  String _phone;

  TextEditingController dateController;

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
            autovalidate: true,
            child: Column(
              //name
              children: <Widget>[
                const SizedBox(height: 20),
                _buildName(),
                const SizedBox(height: 20),
                //date
                _buildDateOfBirth(),
                const SizedBox(height: 20),

                _buildEmail(),
                const SizedBox(height: 20),

                _buildPhone(),
                const SizedBox(height: 50),
                _buildSubmitButon()
              ],
            ),
          ),
        ),
      );

  _buildName() => CommonTextFormField(
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
      );

  _buildDateOfBirth() => CommonTextFormField(
        inputController: dateController,
        prefixIcon: Icon(Icons.date_range),
        hintText: 'Ngày sinh',
        inputType: TextInputType.datetime,
        onClick: () async {
          final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
          if (bottomHeight > 0) {
            Future.delayed(Duration(milliseconds: 1000));
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
          DateTime date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime.now());
          String s = new DateFormat("dd/MM/yyyy").format(date);

          setState(() {
            dateController.text = s;
          });
        },
        validator: (value) {
          if (value.length <= 0) {
            return 'Ngày sinh không được để trống';
          } else {
            return null;
          }
        },
      );

  _buildEmail() => CommonTextFormField(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        onChange: (value) {
          _email = value;
        },
    validator: (value) {
      if (value.length <= 0) {
        return 'Email không được để trống';
      } else {
        return null;
      }
    },
      );

  _buildPhone() => CommonTextFormField(
        hintText: 'Diện thoại',
        inputType: TextInputType.number,
        prefixIcon: Icon(Icons.phone),
        onChange: (value) {
          _phone = value;
        },
        validator: (value) {
          if (value.length != 10) {
            return 'Số điện thoại phải có 10 chữ số';
          } else {
            return null;
          }
        },
      );

  _buildSubmitButon() => InkWell(
        onTap: _submit,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amberAccent),
          child: Center(child: Text('Submit')),
        ),
      );

  _submit() {
    if (key.currentState.validate()) {
      key.currentState.save();
      print('$_name \n ${dateController.text} \n $_email \n $_phone');
    }
  }
}
