import 'package:flutter/material.dart';

class PokeDetailWidget extends StatelessWidget {
  final String title;
  const PokeDetailWidget({Key key, this.title = "PokeDetailWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}
