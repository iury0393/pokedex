class PokeApiV2 {
  int baseExperience;
  int height;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  String name;
  int order;
  int weight;
  Abilities abilities;
  AbilitySingle species;
  GameIndices gameIndices;
  Stats stats;
  Types types;
  Moves moves;

  PokeApiV2({
    this.baseExperience,
    this.height,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.name,
    this.order,
    this.weight,
    this.abilities,
    this.species,
    this.gameIndices,
    this.stats,
    this.types,
    this.moves,
  });

  PokeApiV2.fromJson(Map<String, dynamic> json)
      : baseExperience = json['base_experience'],
        height = json['height'],
        id = json['id'],
        isDefault = json['is_default'],
        locationAreaEncounters = json['location_area_encounters'],
        name = json['name'],
        order = json['order'],
        weight = json['weight'],
        abilities = Abilities.fromJson(json['abilities']),
        species = AbilitySingle.fromJson(json['species']),
        gameIndices = GameIndices.fromJson(json['game_indices']),
        stats = Stats.fromJson(json['stats']),
        types = Types.fromJson(json['types']),
        moves = Moves.fromJson(json['moves']);
}

class Ability {
  AbilitySingle ability;
  bool isHidden;
  int slot;

  Ability({this.ability, this.isHidden, this.slot});

  Ability.fromJson(Map<String, dynamic> json)
      : ability = AbilitySingle.fromJson(json['ability']),
        isHidden = json['is_hidden'],
        slot = json['slot'];
}

class Abilities {
  List<Ability> abilities;

  Abilities({this.abilities});

  Abilities.fromJson(List<dynamic> jsonList)
      : abilities = jsonList.map((e) => Ability.fromJson(e)).toList();
}

class AbilitySingle {
  String name;
  String url;

  AbilitySingle({this.name, this.url});

  AbilitySingle.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}

class GameIndice {
  int gameIndex;
  AbilitySingle version;

  GameIndice({this.gameIndex, this.version});

  GameIndice.fromJson(Map<String, dynamic> json)
      : gameIndex = json['game_index'],
        version = AbilitySingle.fromJson(json['version']);
}

class GameIndices {
  List<GameIndice> indices;

  GameIndices({this.indices});

  GameIndices.fromJson(List<dynamic> jsonList)
      : indices = jsonList.map((e) => GameIndice.fromJson(e)).toList();
}

class Move {
  AbilitySingle move;
  VersionGroupDetails versionGroupDetails;

  Move({this.move, this.versionGroupDetails});

  Move.fromJson(Map<String, dynamic> json)
      : move = AbilitySingle.fromJson(json['move']),
        versionGroupDetails =
            VersionGroupDetails.fromJson(json['version_group_details']);
}

class Moves {
  List<Move> moves;

  Moves({this.moves});

  Moves.fromJson(List<dynamic> jsonList)
      : moves = jsonList.map((e) => Move.fromJson(e)).toList();
}

class VersionGroupDetail {
  int levelLearnedAt;
  AbilitySingle moveLearnMethod;
  AbilitySingle versionGroup;

  VersionGroupDetail(
      {this.levelLearnedAt, this.moveLearnMethod, this.versionGroup});

  VersionGroupDetail.fromJson(Map<String, dynamic> json)
      : levelLearnedAt = json['level_learned_at'],
        moveLearnMethod = AbilitySingle.fromJson(json['move_learn_method']),
        versionGroup = AbilitySingle.fromJson(json['version_group']);
}

class VersionGroupDetails {
  List<VersionGroupDetail> versionGroupDetail;

  VersionGroupDetails({this.versionGroupDetail});

  VersionGroupDetails.fromJson(List<dynamic> jsonList)
      : versionGroupDetail =
            jsonList.map((e) => VersionGroupDetail.fromJson(e)).toList();
}

class Stat {
  int baseStat;
  int effort;
  AbilitySingle stat;

  Stat({this.baseStat, this.effort, this.stat});

  Stat.fromJson(Map<String, dynamic> json)
      : baseStat = json['base_stat'],
        effort = json['effort'],
        stat = AbilitySingle.fromJson(json['stat']);
}

class Stats {
  List<Stat> stats;

  Stats({this.stats});

  Stats.fromJson(List<dynamic> jsonList)
      : stats = jsonList.map((e) => Stat.fromJson(e)).toList();
}

class Type {
  int slot;
  AbilitySingle type;

  Type({this.slot, this.type});

  Type.fromJson(Map<String, dynamic> json)
      : slot = json['slot'],
        type = AbilitySingle.fromJson(json['type']);
}

class Types {
  List<Type> types;

  Types({this.types});

  Types.fromJson(List<dynamic> jsonList)
      : types = jsonList.map((e) => Type.fromJson(e)).toList();
}
