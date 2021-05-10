import 'package:pokedex/app/shared/models/pokeapi_model.dart';

abstract class IHomeRepository {
  Future<PokeAPI> loadPokeAPI();
}
