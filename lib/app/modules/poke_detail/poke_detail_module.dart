import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/modules/poke_detail/poke_detail_widget.dart';

class PokeDetailModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/poke_detail', child: (_, args) => PokeDetailWidget()),
  ];
}
