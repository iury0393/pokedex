import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/app/modules/home/repository/home_repository_interface.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';

class HomeRepository implements IHomeRepository {
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
}
