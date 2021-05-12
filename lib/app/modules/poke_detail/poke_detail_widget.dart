import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
import 'package:pokedex/app/shared/text_styles.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailWidget extends StatefulWidget {
  final int index;

  PokeDetailWidget({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailWidgetState createState() => _PokeDetailWidgetState();
}

class _PokeDetailWidgetState extends State<PokeDetailWidget> {
  final _controller = Modular.get<PokeApiStore>();
  PageController _pageController;
  PokemonModel _pokemon;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemon = _controller.pokemonAtual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            return AppBar(
              title: Opacity(
                child: Text(
                  _pokemon.name,
                  style: TextStyles.paragraph(
                    TextSize.xLarge,
                    weight: FontWeight.bold,
                  ),
                ),
                opacity: 0.0,
              ),
              elevation: 0,
              backgroundColor: _controller.corPokemon,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Observer(
            builder: (context) {
              return Container(color: _controller.corPokemon);
            },
          ),
          Container(height: MediaQuery.of(context).size.height / 3),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            child: SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _controller.setPokemonAtual(index: index);
                  },
                  itemCount: _controller.pokeAPI.pokemon.data.length,
                  itemBuilder: (BuildContext context, int count) {
                    PokemonModel _pokeItem =
                        _controller.getPokemon(index: count);
                    return CachedNetworkImage(
                      height: 60,
                      width: 60,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                    );
                  },
                )),
            padding: EdgeInsets.only(top: 50),
          )
        ],
      ),
    );
  }
}
