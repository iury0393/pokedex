import 'package:flutter/material.dart';
import 'package:pokedex/app/modules/home/app_bar_component.dart';
import 'package:pokedex/app/shared/constants.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                kBlackPokeball,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusWidth,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                      child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
