import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';

class CircularProgressAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Modular.get<PokeApiStore>().corPokemon,
            ),
          ),
        ),
      ),
    );
  }
}
