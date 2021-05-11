import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/global_repository/global_repository.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
part 'poke_api_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  final GlobalRepository globalRepository = Modular.get<GlobalRepository>();

  @observable
  PokeApi _pokeAPI;

  @computed
  PokeApi get pokeAPI => _pokeAPI;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    globalRepository.loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  @action
  Widget getImage({String num}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: CachedNetworkImage(
        height: 80,
        width: 80,
        placeholder: (context, url) => new Container(
          color: Colors.transparent,
        ),
        imageUrl:
            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
      ),
    );
  }

  @action
  getPokemon({int index}) {
    return _pokeAPI.pokemon.data[index];
  }
}
