import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
import 'package:pokedex/app/shared/text_styles.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailWidget extends StatelessWidget {
  final int index;

  Color _corPokemon;

  PokeDetailWidget({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Modular.get<PokeApiStore>();
    PokemonModel _pokemon = _pokemonStore.pokemonAtual;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            _corPokemon =
                kGetColorType(type: _pokemonStore.pokemonAtual.type[0]);
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
              backgroundColor: _corPokemon,
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
              _corPokemon =
                  kGetColorType(type: _pokemonStore.pokemonAtual.type[0]);
              return Container(color: _corPokemon);
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
                  onPageChanged: (index) {
                    _pokemonStore.setPokemonAtual(index: index);
                  },
                  itemCount: _pokemonStore.pokeAPI.pokemon.data.length,
                  itemBuilder: (BuildContext context, int count) {
                    PokemonModel _pokeitem =
                        _pokemonStore.getPokemon(index: count);
                    return CachedNetworkImage(
                      height: 60,
                      width: 60,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
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
