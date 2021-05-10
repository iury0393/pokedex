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
  getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }
}
