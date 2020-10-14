import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final TrackingScrollController scrollController;
  const Header(this.scrollController);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color _backgroundColor;
  Color _backgroundColorSearch;
  Color _colorIcon;
  double _opacity;
  double _offset;
  final _opacityMax = 0.01;
  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.white;
    _opacity = 0.0;
    _offset = 0.0;

    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('hopelope',style: TextStyle(color:_colorIcon),)
            //  _buildInputSearch()
            ],
          ),
        ),
      ),
    );
  }

 final  sizeIcon= BoxConstraints(
   minHeight: 40,
   minWidth: 40
 );

 final border = OutlineInputBorder(
   borderSide: const BorderSide(
     color: Colors.transparent,
     width: 0
   ),
   borderRadius: BorderRadius.all(const Radius.circular(20)),
 );

  _buildInputSearch(){
    return Expanded(
          child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          isDense: true,
          enabledBorder: border,
          focusedBorder: border,
          hintText: 'Shopee',
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.green[50]
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: sizeIcon,
          suffixIcon: Icon(Icons.camera_alt),
          suffixIconConstraints: sizeIcon,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.tryParse((_opacity + _opacityMax).toStringAsFixed(2));

      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    } else if (scrollOffset < 100) {
      _opacity = double.tryParse((_opacity + _opacityMax).toStringAsFixed(2));

      if (_opacity <= 1.0) {
        _opacity = 0.0;
      }
    }

    setState(() {
      if (scrollOffset <= 0) {
        _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.white;
        _opacity = 0.0;
        _offset = 0.0;
      } else {
        _backgroundColorSearch = Colors.grey[200];
        _colorIcon = Colors.deepOrange;
        }

        _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
