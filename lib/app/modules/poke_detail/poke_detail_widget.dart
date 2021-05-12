import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/poke_api_store.dart';
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
  final _controller = Modular.get<PokeApiStore>();
  PageController _pageController;
  MultiTrackTween _animation;
  double _progress;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
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
            name: 'Color',
            builder: (context) {
              return AnimatedContainer(
                color: _controller.corPokemon,
                duration: Duration(milliseconds: 300),
                child: AppBar(
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
                                  opacity:
                                      _opacityTitleAppBar >= 0.2 ? 0.2 : 0.0,
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
              );
            },
          ),
          Observer(
              name: 'NomePokemon',
              builder: (context) {
                return Padding(
                  child: Text(
                    _controller.pokemonAtual.name,
                    style: TextStyles.paragraph(
                      TextSize.xxBig - _progress * 10,
                      weight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 100 - _progress * 53,
                    left: 30 + _progress * 20,
                  ),
                );
              }),
          Container(height: MediaQuery.of(context).size.height / 3),
          SlidingSheet(
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiple = 1 - interval(0.50, 0.87, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar =
                    _multiple = interval(0.50, 0.87, _progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.50, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
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
                    _controller.setPokemonAtual(index: index);
                  },
                  itemCount: _controller.pokeAPI.pokemon.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    PokemonModel _pokeitem =
                        _controller.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
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
                                  opacity: index == _controller.posicaoAtual
                                      ? 0.2
                                      : 0,
                                  duration: Duration(milliseconds: 200),
                                ),
                                angle: animation['rotation'],
                              );
                            }),
                        Observer(
                            name: 'Pokemon',
                            builder: (context) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  AnimatedPadding(
                                    child: Hero(
                                      tag: index == _controller.posicaoAtual
                                          ? _pokeitem.name
                                          : 'none',
                                      child: CachedNetworkImage(
                                        height: 160,
                                        width: 160,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.transparent,
                                        ),
                                        color: index == _controller.posicaoAtual
                                            ? null
                                            : Colors.black.withOpacity(0.5),
                                        imageUrl:
                                            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                    padding: EdgeInsets.only(
                                      top: index == _controller.posicaoAtual
                                          ? 0
                                          : 60,
                                      bottom: index == _controller.posicaoAtual
                                          ? 0
                                          : 60,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  },
                ),
              ),
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1 ? 1000 : 200 - _progress * 50),
            ),
          ),
        ],
      ),
    );
  }
}
