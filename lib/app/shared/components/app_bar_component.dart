import 'package:flutter/material.dart';
import 'package:pokedex/app/shared/text_styles.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25, right: 5),
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Pokedex',
                  style: TextStyles.paragraph(
                    TextSize.xBig,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      height: 120,
    );
  }
}
