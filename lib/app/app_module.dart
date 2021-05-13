import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/global_repository/global_repository.dart';
import 'package:pokedex/app/modules/poke_detail/poke_detail_widget.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/poke_api_v2_store.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => PokeApiStore()),
    Bind.singleton((i) => PokeApiV2Store()),
    Bind.factory((i) => GlobalRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ChildRoute(
      '/poke_detail',
      child: (_, args) => PokeDetailWidget(
        index: args.data,
      ),
    ),
  ];
}
