import 'package:flutter/material.dart';

class GridSizeMenu extends StatefulWidget {
  const GridSizeMenu({super.key});

  @override
  _GridSizeMenuState createState() => _GridSizeMenuState();
}

class _GridSizeMenuState extends State<GridSizeMenu> {
  String _selectedOption = '6x6';
  final List<String> _options = ['6x6', '8x8', '10x10'];

  @override
  Widget build(BuildContext context) {
    final double width = 0.85 * MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff373855),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Theme(
          data: ThemeData(
            canvasColor: Color(0xff373855),
          ),
          child: DropdownButton<String>(
            underline: SizedBox(),
            value: _selectedOption,
            iconEnabledColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? value) {
              setState(() {
                _selectedOption = value!;
              });
            },
            items: _options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: SizedBox(
                  width: width - 32,
                  child: Text(
                    option,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}