import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/modules/abas/evolucao_widget.dart';
import 'package:pokedex/app/modules/abas/sobre_widget.dart';
import 'package:pokedex/app/modules/abas/status_widget.dart';
import 'package:pokedex/app/poke_api_store.dart';
import 'package:pokedex/app/shared/text_styles.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  final _pokemonStore = Modular.get<PokeApiStore>();
  TabController _tabController;
  PageController _pageController;
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    _disposer = reaction(
      (f) => _pokemonStore.pokemonAtual,
      (r) => _pageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Observer(builder: (context) {
            return TabBar(
              onTap: (index) {
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              controller: _tabController,
              labelStyle: TextStyles.paragraph(
                TextSize.medium,
                weight: FontWeight.w700,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: _pokemonStore.corPokemon,
              unselectedLabelColor: Color(0xff5f6368),
              isScrollable: true,
              indicator: MD2Indicator(
                  indicatorHeight: 3,
                  indicatorColor: _pokemonStore.corPokemon,
                  indicatorSize: MD2IndicatorSize.normal),
              tabs: [
                Tab(
                  text: "Sobre",
                ),
                Tab(
                  text: "Evolução",
                ),
                Tab(
                  text: "Status",
                ),
              ],
            );
          }),
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabController.animateTo(index,
              duration: Duration(milliseconds: 300));
        },
        controller: _pageController,
        children: [
          SobreWidget(),
          EvolucaoWidget(),
          StatusWidget(),
        ],
      ),
    );
  }
}
