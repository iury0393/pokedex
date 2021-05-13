import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_v2_model.dart';
import 'package:pokedex/app/shared/models/specie_model.dart';

part 'poke_api_v2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  @observable
  Specie specie;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String nome) async {
    try {
      Response response = await Dio().get(kPokeapiv2URL + nome.toLowerCase());
      var decodeJson = jsonDecode(response.data);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(String numPokemon) async {
    try {
      specie = null;
      Response response = await Dio().get(kPokeapiv2EspeciesURL + numPokemon);
      var decodeJson = jsonDecode(response.data);
      var _specie = Specie.fromJson(decodeJson);
      specie = _specie;
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
