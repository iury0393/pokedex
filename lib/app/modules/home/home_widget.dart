import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/modules/home/home_controller.dart';
import 'package:pokedex/app/shared/components/app_bar_component.dart';
import 'package:pokedex/app/shared/constants.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeController _controller = Modular.get();

  @override
  void initState() {
    super.initState();
    _controller.fetchPokemonList();
  }

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
                    child: Observer(
                      builder: (_) {
                        return (_controller.pokeAPI != null)
                            ? ListView.builder(
                                itemCount: _controller.pokeAPI.pokemon.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_controller
                                        .pokeAPI.pokemon[index].name),
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
