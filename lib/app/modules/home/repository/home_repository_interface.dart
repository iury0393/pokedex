import 'package:pokedex/app/shared/models/pokemon_model.dart';

abstract class IHomeRepository {
  Future<PokeApi> loadPokeAPI();
}
