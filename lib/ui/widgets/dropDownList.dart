import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final onChange;
  final items;
  final hint;
  const DropDownList({Key key, this.onChange, this.items, this.hint})
      : super(key: key);
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  var val;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xFF707070),
            width: 1.2,
            style: BorderStyle.solid,
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: val,
          hint: Text(
            widget.hint,
            style: TextStyle(
                fontFamily: "Montserrat-Medium",
                color: Color(0xFF707070),
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          items: List.generate(
              widget.items.length,
              (index) => DropdownMenuItem(
                    value: widget.items[index],
                    child: Text(
                      widget.items[index],
                      style: TextStyle(
                          fontFamily: "Montserrat-Medium",
                          color: Color(0xFF707070),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
          onChanged: (value) {
            setState(() {
              val = value;
            });
            widget.onChange(value);
          },
          isExpanded: true,
          icon: IconButton(
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Color(0xFF707070),
              ),
              onPressed: null),
          iconSize: 15,
        ),
      ),
    );
  }
}
