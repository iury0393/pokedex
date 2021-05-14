import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/poke_api_v2_store.dart';
import 'package:pokedex/app/shared/components/circular_progress_component.dart';
import 'package:pokedex/app/shared/models/specie_model.dart';
import 'package:pokedex/app/shared/text_styles.dart';

class SobreWidget extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = Modular.get<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = Modular.get<PokeApiStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Descrição',
              style: TextStyles.paragraph(
                TextSize.small,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Observer(builder: (context) {
              Specie _specie = _pokeApiV2Store.specie;
              return SizedBox(
                  height: 70,
                  child: SingleChildScrollView(
                      child: _specie != null
                          ? Text(
                              _specie.flavorTextEntries.flavorTextEntries
                                  .where((item) => item.language.name == 'en')
                                  .first
                                  .flavorText,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          : CircularProgressAbout()));
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              'Biologia',
              style: TextStyles.paragraph(
                TextSize.small,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Observer(builder: (context) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Altura',
                          style: TextStyles.paragraph(
                            TextSize.xSmall,
                            weight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokeApiStore.pokemonAtual.height,
                          style: TextStyles.paragraph(
                            TextSize.xxSmall,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Peso',
                          style: TextStyles.paragraph(
                            TextSize.xSmall,
                            weight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokeApiStore.pokemonAtual.weight,
                          style: TextStyles.paragraph(
                            TextSize.xxSmall,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
