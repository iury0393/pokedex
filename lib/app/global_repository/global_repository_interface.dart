import 'package:pokedex/app/shared/models/pokemon_model.dart';

abstract class IGlobalRepository {
  Future<PokeApi> loadPokeAPI();
}
