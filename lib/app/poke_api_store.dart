import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/global_repository/global_repository.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
part 'poke_api_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  final GlobalRepository globalRepository = Modular.get<GlobalRepository>();

  @observable
  PokeApi _pokeAPI;

  @observable
  PokemonModel _pokemonAtual;

  @observable
  Color corPokemon;

  @observable
  int posicaoAtual;

  @computed
  PokeApi get pokeAPI => _pokeAPI;

  @computed
  PokemonModel get pokemonAtual => _pokemonAtual;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    globalRepository.loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  PokemonModel getPokemon({int index}) {
    return _pokeAPI.pokemon.data[index];
  }

  @action
  setPokemonAtual({int index}) {
    _pokemonAtual = _pokeAPI.pokemon.data[index];
    corPokemon = kGetColorType(type: _pokemonAtual.type[0]);
    posicaoAtual = index;
  }

  @action
  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }
}
