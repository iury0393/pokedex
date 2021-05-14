import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/global_repository/global_repository.dart';
import 'package:pokedex/app/shared/models/pokemon_v2_model.dart';
import 'package:pokedex/app/shared/models/specie_model.dart';

part 'poke_api_v2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  final GlobalRepository globalRepository = Modular.get<GlobalRepository>();

  @observable
  Specie _specie;

  @observable
  PokeApiV2 _pokeApiV2;

  @computed
  Specie get specie => _specie;

  @computed
  PokeApiV2 get pokeApiV2 => _pokeApiV2;

  @action
  Future<void> getInfoPokemon(String nome) async {
    _pokeApiV2 = null;
    globalRepository.getInfoPokemon(nome).then((pokeListV2) {
      _pokeApiV2 = pokeListV2;
    });
  }

  @action
  Future<void> getInfoSpecie(String numPokemon) async {
    _specie = null;
    globalRepository.getInfoSpecies(numPokemon).then((species) {
      _specie = species;
    });
  }
}
