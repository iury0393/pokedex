import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/modules/home/home_controller.dart';
import 'package:pokedex/app/modules/home/home_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomeWidget()),
  ];
}
