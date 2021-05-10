import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/modules/home/repository/home_repository.dart';
import 'package:pokedex/app/shared/models/pokeapi_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeRepository homeRepository = HomeRepository();

  @observable
  PokeAPI _pokeAPI;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    homeRepository.loadPokeAPI().then((pokeList) {
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
    return _pokeAPI.pokemon[index];
  }
}
