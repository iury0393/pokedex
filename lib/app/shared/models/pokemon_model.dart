class PokeApi {
  PokemonsModel pokemon;

  PokeApi({this.pokemon});

  PokeApi.fromJson(Map<String, dynamic> json)
      : pokemon = PokemonsModel.fromJson(json['pokemon']);
}

class PokemonsModel {
  List<PokemonModel> data;

  PokemonsModel({this.data});

  PokemonsModel.fromJson(List<dynamic> jsonList)
      : data = jsonList.map((e) => PokemonModel.fromJson(e)).toList();
}

class PokemonModel {
  int id;
  String num;
  String name;
  String img;
  String height;
  String weight;
  String candy;
  String egg;
  List<String> type;
  NextEvolutionsModel nextEvolution;
  PrevEvolutionsModel prevEvolution;

  PokemonModel({
    this.id,
    this.num,
    this.name,
    this.img,
    this.height,
    this.weight,
    this.candy,
    this.egg,
    this.type,
    this.nextEvolution,
    this.prevEvolution,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    height = json['height'];
    weight = json['weight'];
    candy = json['candy'];
    egg = json['egg'];
    type = json['type'].cast<String>();
    if (json['next_evolution'] != null) {
      nextEvolution = NextEvolutionsModel.fromJson(json['next_evolution']);
    }
    if (json['prev_evolution'] != null) {
      prevEvolution = PrevEvolutionsModel.fromJson(json['prev_evolution']);
    }
  }
}

class NextEvolutionModel {
  String num;
  String name;

  NextEvolutionModel({this.num, this.name});

  NextEvolutionModel.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        name = json['name'];
}

class NextEvolutionsModel {
  List<NextEvolutionModel> nextEvolution;

  NextEvolutionsModel({this.nextEvolution});

  NextEvolutionsModel.fromJson(List<dynamic> jsonList)
      : nextEvolution =
            jsonList.map((e) => NextEvolutionModel.fromJson(e)).toList();
}

class PrevEvolutionModel {
  String num;
  String name;

  PrevEvolutionModel({this.num, this.name});

  PrevEvolutionModel.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        name = json['name'];
}

class PrevEvolutionsModel {
  List<PrevEvolutionModel> prevEvolution;

  PrevEvolutionsModel({this.prevEvolution});

  PrevEvolutionsModel.fromJson(List<dynamic> jsonList)
      : prevEvolution =
            jsonList.map((e) => PrevEvolutionModel.fromJson(e)).toList();
}
