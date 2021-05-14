class Specie {
  int baseHappiness;
  int captureRate;
  ObjPokemon color;
  EvolutionChain evolutionChain;
  bool formsSwitchable;
  int genderRate;
  ObjPokemon generation;
  ObjPokemon growthRate;
  ObjPokemon habitat;
  bool hasGenderDifferences;
  int hatchCounter;
  int id;
  bool isBaby;
  String name;
  int order;
  ObjPokemon shape;
  PalParkEncounters palParkEncounters;
  PokedexNumbers pokedexNumbers;
  Varieties varieties;
  FlavorTextEntries flavorTextEntries;
  Generas genera;
  Names names;

  Specie({
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.evolutionChain,
    this.flavorTextEntries,
    this.formsSwitchable,
    this.genderRate,
    this.genera,
    this.generation,
    this.growthRate,
    this.habitat,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.isBaby,
    this.name,
    this.names,
    this.order,
    this.palParkEncounters,
    this.pokedexNumbers,
    this.shape,
    this.varieties,
  });

  Specie.fromJson(Map<String, dynamic> json)
      : baseHappiness = json['base_happiness'],
        captureRate = json['capture_rate'],
        hasGenderDifferences = json['has_gender_differences'],
        hatchCounter = json['hatch_counter'],
        id = json['id'],
        isBaby = json['is_baby'],
        name = json['name'],
        order = json['order'],
        genderRate = json['gender_rate'],
        formsSwitchable = json['forms_switchable'],
        color = ObjPokemon.fromJson(json['color']),
        evolutionChain = EvolutionChain.fromJson(json['evolution_chain']),
        generation = ObjPokemon.fromJson(json['generation']),
        growthRate = ObjPokemon.fromJson(json['growth_rate']),
        shape = ObjPokemon.fromJson(json['shape']),
        flavorTextEntries =
            FlavorTextEntries.fromJson(json['flavor_text_entries']),
        genera = Generas.fromJson(json['genera']),
        names = Names.fromJson(json['names']),
        palParkEncounters =
            PalParkEncounters.fromJson(json['pal_park_encounters']),
        pokedexNumbers = PokedexNumbers.fromJson(json['pokedex_numbers']),
        varieties = Varieties.fromJson(json['varieties']);
}

class ObjPokemon {
  String name;
  String url;

  ObjPokemon({this.name, this.url});

  ObjPokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class EvolutionChain {
  String url;

  EvolutionChain({this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}

class FlavorTextEntry {
  String flavorText;
  ObjPokemon language;
  ObjPokemon version;

  FlavorTextEntry({this.flavorText, this.language, this.version});

  FlavorTextEntry.fromJson(Map<String, dynamic> json)
      : flavorText = json['flavor_text'],
        language = ObjPokemon.fromJson(json['language']),
        version = ObjPokemon.fromJson(json['version']);
}

class FlavorTextEntries {
  List<FlavorTextEntry> flavorTextEntries;

  FlavorTextEntries({this.flavorTextEntries});

  FlavorTextEntries.fromJson(List<dynamic> jsonList)
      : flavorTextEntries =
            jsonList.map((e) => FlavorTextEntry.fromJson(e)).toList();
}

class Genera {
  String genus;
  ObjPokemon language;

  Genera({this.genus, this.language});

  Genera.fromJson(Map<String, dynamic> json)
      : genus = json['genus'],
        language = ObjPokemon.fromJson(json['language']);
}

class Generas {
  List<Genera> genera;

  Generas({this.genera});

  Generas.fromJson(List<dynamic> jsonList)
      : genera = jsonList.map((e) => Genera.fromJson(e)).toList();
}

class Name {
  ObjPokemon language;
  String name;

  Name({this.language, this.name});

  Name.fromJson(Map<String, dynamic> json)
      : language = ObjPokemon.fromJson(json['language']),
        name = json['name'];
}

class Names {
  List<Name> names;

  Names({this.names});

  Names.fromJson(List<dynamic> jsonList)
      : names = jsonList.map((e) => Name.fromJson(e)).toList();
}

class PalParkEncounter {
  ObjPokemon area;
  int baseScore;
  int rate;

  PalParkEncounter({this.area, this.baseScore, this.rate});

  PalParkEncounter.fromJson(Map<String, dynamic> json)
      : area = ObjPokemon.fromJson(json['area']),
        baseScore = json['base_score'],
        rate = json['rate'];
}

class PalParkEncounters {
  List<PalParkEncounter> palParkEncounter;

  PalParkEncounters({this.palParkEncounter});

  PalParkEncounters.fromJson(List<dynamic> jsonList)
      : palParkEncounter =
            jsonList.map((e) => PalParkEncounter.fromJson(e)).toList();
}

class PokedexNumber {
  int entryNumber;
  ObjPokemon pokedex;

  PokedexNumber({this.entryNumber, this.pokedex});

  PokedexNumber.fromJson(Map<String, dynamic> json)
      : entryNumber = json['entry_number'],
        pokedex = ObjPokemon.fromJson(json['pokedex']);
}

class PokedexNumbers {
  List<PokedexNumber> pokedexNumbers;

  PokedexNumbers({this.pokedexNumbers});

  PokedexNumbers.fromJson(List<dynamic> jsonList)
      : pokedexNumbers =
            jsonList.map((e) => PokedexNumber.fromJson(e)).toList();
}

class Varietie {
  bool isDefault;
  ObjPokemon pokemon;

  Varietie({this.isDefault, this.pokemon});

  Varietie.fromJson(Map<String, dynamic> json)
      : isDefault = json['is_default'],
        pokemon = ObjPokemon.fromJson(json['pokemon']);
}

class Varieties {
  List<Varietie> pokedexNumbers;

  Varieties({this.pokedexNumbers});

  Varieties.fromJson(List<dynamic> jsonList)
      : pokedexNumbers = jsonList.map((e) => Varietie.fromJson(e)).toList();
}
