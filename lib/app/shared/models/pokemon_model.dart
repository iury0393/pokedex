class Pokemons {
  List<Pokemon> pokemon;

  Pokemons({this.pokemon});

  Pokemons.fromJson(List<dynamic> jsonList)
      : pokemon = jsonList.map((e) => Pokemon.fromJson(e)).toList();
}

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  Types type;
  String height;
  String weight;
  String candy;
  String egg;
  NextEvolutionsModel nextEvolution;
  PrevEvolutionsModel prevEvolution;

  Pokemon(
      {this.id,
      this.num,
      this.name,
      this.img,
      this.type,
      this.height,
      this.weight,
      this.candy,
      this.egg,
      this.nextEvolution,
      this.prevEvolution});

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        num = json['num'],
        name = json['name'],
        img = json['img'],
        type = Types.fromJson(json['type']),
        height = json['height'],
        weight = json['weight'],
        candy = json['candy'],
        egg = json['egg'],
        nextEvolution = NextEvolutionsModel.fromJson(json['next_evolution']),
        prevEvolution = PrevEvolutionsModel.fromJson(json['prev_evolution']);
}

class Type {
  String type;

  Type({this.type});

  Type.fromJson(Map<String, dynamic> json) : type = json['type'];
}

class Types {
  List<Type> type;

  Types({this.type});

  Types.fromJson(List<dynamic> jsonList)
      : type = jsonList.map((e) => Type.fromJson(e)).toList();
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
