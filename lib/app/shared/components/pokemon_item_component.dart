import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/text_styles.dart';

class PokemonItemComponent extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokemonItemComponent(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyles.paragraph(
                    TextSize.xxSmall,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            //alignment: Alignment.bottomRight,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      name,
                      style: TextStyles.paragraph(
                        TextSize.small,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setTipos(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  child: Image.asset(
                    kWhitePokeball,
                    height: 80,
                    width: 80,
                  ),
                  opacity: 0.2,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  placeholder: (context, url) => new Container(
                    color: Colors.transparent,
                  ),
                  imageUrl:
                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: kGetColorType(type: types[0]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
