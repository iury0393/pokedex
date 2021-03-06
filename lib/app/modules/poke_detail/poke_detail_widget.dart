import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/modules/abas/about_page.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/poke_api_v2_store.dart';
import 'package:pokedex/app/shared/constants.dart';
import 'package:pokedex/app/shared/models/pokemon_model.dart';
import 'package:pokedex/app/shared/text_styles.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailWidget extends StatefulWidget {
  final int index;

  PokeDetailWidget({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailWidgetState createState() => _PokeDetailWidgetState();
}

class _PokeDetailWidgetState extends State<PokeDetailWidget> {
  final _pokemonStore = Modular.get<PokeApiStore>();
  final _pokeApiV2Store = Modular.get<PokeApiV2Store>();
  PageController _pageController;
  MultiTrackTween _animation;
  double _progress = 0;
  double _multiple = 1;
  double _opacity = 1;
  double _opacityTitleAppBar = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.index,
      viewportFraction: 0.5,
    );
    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
    _pokeApiV2Store.getInfoPokemon(_pokemonStore.pokemonAtual.name);
    _pokeApiV2Store.getInfoSpecie(_pokemonStore.pokemonAtual.id.toString());
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      _pokemonStore.corPokemon.withOpacity(0.7),
                      _pokemonStore.corPokemon,
                    ])),
                child: Stack(
                  children: [
                    AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Modular.to.pop(),
                      ),
                      actions: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ControlledAnimation(
                                playback: Playback.LOOP,
                                duration: _animation.duration,
                                tween: _animation,
                                builder: (context, animation) {
                                  return Transform.rotate(
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 200),
                                      child: Image.asset(
                                        kWhitePokeball,
                                        height: 50,
                                        width: 50,
                                      ),
                                      opacity: _opacityTitleAppBar >= 0.2
                                          ? 0.2
                                          : 0.0,
                                    ),
                                    angle: animation['rotation'],
                                  );
                                }),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () => Modular.to.pop(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.12 -
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      left: 20 +
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      child: Text(
                        _pokemonStore.pokemonAtual.name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 38 -
                                _progress *
                                    (MediaQuery.of(context).size.height *
                                        0.011),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.16,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              setTipos(_pokemonStore.pokemonAtual.type),
                              Text(
                                '#' + _pokemonStore.pokemonAtual.num.toString(),
                                style: TextStyle(
                                    fontFamily: 'Google',
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
              );
            },
          ),
          SlidingSheet(
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiple = 1 - interval(0.60, 0.87, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar = interval(0.60, 0.87, _progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.60, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.12,
                child: AboutPage(),
              );
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokemonStore.setPokemonAtual(index: index);
                    _pokeApiV2Store
                        .getInfoPokemon(_pokemonStore.pokemonAtual.name);
                    _pokeApiV2Store.getInfoSpecie(
                        _pokemonStore.pokemonAtual.id.toString());
                  },
                  itemCount: _pokemonStore.pokeAPI.pokemon.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    PokemonModel _pokeitem =
                        _pokemonStore.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ControlledAnimation(
                            playback: Playback.LOOP,
                            duration: _animation.duration,
                            tween: _animation,
                            builder: (context, animation) {
                              return Transform.rotate(
                                child: AnimatedOpacity(
                                  child: Image.asset(
                                    kWhitePokeball,
                                    height: 270,
                                    width: 270,
                                  ),
                                  opacity: index == _pokemonStore.posicaoAtual
                                      ? 0.2
                                      : 0,
                                  duration: Duration(milliseconds: 200),
                                ),
                                angle: animation['rotation'],
                              );
                            }),
                        IgnorePointer(
                          child: Observer(
                            name: 'Pokemon',
                            builder: (context) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  AnimatedPadding(
                                    child: Hero(
                                      tag: index == _pokemonStore.posicaoAtual
                                          ? _pokeitem.name
                                          : 'none' + index.toString(),
                                      child: CachedNetworkImage(
                                        height: 160,
                                        width: 160,
                                        placeholder: (context, url) =>
                                            new Container(
                                          color: Colors.transparent,
                                        ),
                                        color:
                                            index == _pokemonStore.posicaoAtual
                                                ? null
                                                : Colors.black.withOpacity(0.5),
                                        imageUrl:
                                            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                    padding: EdgeInsets.only(
                                        top: index == _pokemonStore.posicaoAtual
                                            ? 0
                                            : 60,
                                        bottom:
                                            index == _pokemonStore.posicaoAtual
                                                ? 0
                                                : 60),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1
                      ? 1000
                      : (MediaQuery.of(context).size.height * 0.25) -
                          _progress * 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget setTipos(List<String> types) {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Row(
          children: [
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
                    TextSize.medium,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
