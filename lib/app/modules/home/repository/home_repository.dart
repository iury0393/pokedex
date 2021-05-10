import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/app/modules/home/repository/home_repository_interface.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokeapi_model.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await Dio().get(kBaseURL);
      var decodeJson = jsonDecode(response.data);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
