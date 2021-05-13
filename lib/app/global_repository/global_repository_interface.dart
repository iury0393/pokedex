import 'package:pokedex/app/shared/models/pokemon_model.dart';
import 'package:pokedex/app/shared/models/pokemon_v2_model.dart';
import 'package:pokedex/app/shared/models/specie_model.dart';

abstract class IGlobalRepository {
  Future<PokeApi> loadPokeAPI();
  Future<PokeApiV2> getInfoPokemon(String nome);
  Future<Specie> getInfoSpecies(String numPokemon);
}
