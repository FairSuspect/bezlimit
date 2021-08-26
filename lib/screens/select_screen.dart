import 'package:bezlimit/getx/main.dart';
import 'package:bezlimit/helpers/formatters.dart';
import 'package:bezlimit/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectScreen extends StatefulWidget {
  final int index;
  SelectScreen({Key? key, required this.index}) : super(key: key);

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  FocusNode _focusScopeNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey();
  Controller c = Get.find();

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Get.focusScope!.unfocus();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  focusNode: _focusScopeNode,
                  inputFormatters: [NumberFormatter()],
                  initialValue: widget.index.toString(),
                  validator: Validators.number,
                  onFieldSubmitted: (value) {
                    _onSavePressed();
                  },
                  onSaved: (newValue) {
                    c.count(int.parse(newValue ?? "0"));
                  },
                ),
                ElevatedButton.icon(
                    onPressed: _onSavePressed,
                    icon: Icon(Icons.save),
                    label: Text("Сохранить"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
