import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';

class EvolucaoWidget extends StatelessWidget {
  final PokeApiStore _pokeApiStore = Modular.get<PokeApiStore>();

  Widget resizePokemon(Widget widget) {
    return SizedBox(height: 80, width: 80, child: widget);
  }

  List<Widget> getEvolucao(PokemonModel pokemon) {
    List<Widget> _list = [];
    if (pokemon.prevEvolution != null) {
      pokemon.prevEvolution.prevEvolution.forEach((f) {
        _list.add(resizePokemon(_pokeApiStore.getImage(numero: f.num)));
        _list.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              f.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        _list.add(Icon(Icons.keyboard_arrow_down));
      });
    }
    _list.add(resizePokemon(
        _pokeApiStore.getImage(numero: _pokeApiStore.pokemonAtual.num)));
    _list.add(
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          _pokeApiStore.pokemonAtual.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (pokemon.nextEvolution != null) {
      _list.add(Icon(Icons.keyboard_arrow_down));
      pokemon.nextEvolution.nextEvolution.forEach((f) {
        _list.add(resizePokemon(_pokeApiStore.getImage(numero: f.num)));
        _list.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              f.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        if (pokemon.nextEvolution.nextEvolution.last.name != f.name) {
          _list.add(Icon(Icons.keyboard_arrow_down));
        }
      });
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Observer(builder: (context) {
          PokemonModel pokemon = _pokeApiStore.pokemonAtual;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getEvolucao(pokemon),
            ),
          );
        }),
      ),
    );
  }
}
