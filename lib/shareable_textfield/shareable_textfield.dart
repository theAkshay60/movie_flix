import 'package:flutter/material.dart';

class ShareableTextField extends StatelessWidget {

  final Function onChanged;

  ShareableTextField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black54,
      onTap: (){
        print('textfield tapped');
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}