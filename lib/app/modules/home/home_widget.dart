import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/shared/components/app_bar_component.dart';
import 'package:pokedex/app/shared/components/pokemon_item_component.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final PokeApiStore _controller = Modular.get<PokeApiStore>();

  @override
  void initState() {
    super.initState();
    if (_controller.pokeAPI == null) {
      _controller.fetchPokemonList();
    }
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
            top: MediaQuery.of(context).padding.top - 240 / 2.9,
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
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _controller.pokeAPI.pokemon.data.length,
                                  itemBuilder: (context, index) {
                                    PokemonModel pokemon =
                                        _controller.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokemonItemComponent(
                                            types: pokemon.type,
                                            index: index,
                                            name: pokemon.name,
                                            image: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CachedNetworkImage(
                                                height: 80,
                                                width: 80,
                                                placeholder: (context, url) =>
                                                    new Container(
                                                  color: Colors.transparent,
                                                ),
                                                imageUrl:
                                                    'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${pokemon.num}.png',
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            _controller.setPokemonAtual(
                                                index: index);
                                            Modular.to.pushNamed('poke_detail',
                                                arguments: index);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
