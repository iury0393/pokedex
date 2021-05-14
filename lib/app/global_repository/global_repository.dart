import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/app/global_repository/global_repository_interface.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
import 'package:pokedex/app/shared/models/pokemon_v2_model.dart';
import 'package:pokedex/app/shared/models/specie_model.dart';

class GlobalRepository implements IGlobalRepository {
  @override
  Future<PokeApi> loadPokeAPI() async {
    try {
      Response response = await Dio().get(kBaseURL);
      var decodeJson = jsonDecode(response.data);
      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<PokeApiV2> getInfoPokemon(String nome) async {
    try {
      Response response = await Dio().get(kPokeapiv2URL + nome.toLowerCase());
      return PokeApiV2.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<Specie> getInfoSpecies(String numPokemon) async {
    try {
      Response response = await Dio().get(kPokeapiv2EspeciesURL + numPokemon);
      return Specie.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
