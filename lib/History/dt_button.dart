import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';

class DTButton extends StatefulWidget {
  final Function updateChartsStatus;

  const DTButton({ Key key, this.updateChartsStatus }) : super(key: key);

  @override
  _DTButtonState createState() => _DTButtonState();
}

class _DTButtonState extends State<DTButton> {
  String getDateTimeText() => '${_dtb_currentDateTime.day}/${_dtb_currentDateTime.month}/${_dtb_currentDateTime.year}';
  // ignore: non_constant_identifier_names
  DateTime _dtb_currentDateTime;
  DateTime get dateTime => _dtb_currentDateTime;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    DateTime currentDatetime = DateTime.now();
    setState(() {
      _dtb_currentDateTime = DateTime(currentDatetime.year, currentDatetime.month, currentDatetime.day);
    });
  }

  Future sd(BuildContext ctx) async {
    final _idt = DateTime.now();
    final ud = await showDatePicker(
      initialDate: _dtb_currentDateTime ?? _idt,
      context: ctx, 
      lastDate: _idt,
      firstDate: DateTime(_idt.year - 10),
    );

    if (ud != null)
      return ud;
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent
        ),
        icon: Icon(Ionicons.calendar_sharp),
        onPressed: () async {
          var date = await sd(context);

          if (date == null || (_dtb_currentDateTime.year == date.year && 
              _dtb_currentDateTime.month == date.month &&
              _dtb_currentDateTime.day == date.day)
          )
            return;

          setState(() {
            _dtb_currentDateTime = DateTime(date.year, date.month, date.day);
          });

          DateTime currentDatetime = DateTime.now();

          if (currentDatetime.year == date.year && 
              currentDatetime.month == date.month &&
              currentDatetime.day == date.day
          )
            widget.updateChartsStatus(true);
          else
            widget.updateChartsStatus(false);
        },
        label: Text(getDateTimeText()),
      ),
      width: size.width*0.79,
    );
  }
}