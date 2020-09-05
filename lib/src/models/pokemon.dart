import 'dart:convert';

class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int candyCount;
  final String egg;
  final String spawnChance;
  final String avgSpawns;
  final String spawnTime;
  final List<double> multipliers;
  final List<String> weaknesses;
  final List<NextEvolution> nextEvolution;

  Pokemon(
      {this.id,
      this.num,
      this.name,
      this.img,
      this.type,
      this.height,
      this.weight,
      this.candy,
      this.candyCount,
      this.egg,
      this.spawnChance,
      this.avgSpawns,
      this.spawnTime,
      this.multipliers,
      this.weaknesses,
      this.nextEvolution});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'num': num,
      'name': name,
      'img': img,
      'type': type,
      'height': height,
      'weight': weight,
      'candy': candy,
      'candy_count': candyCount,
      'egg': egg,
      'spawn_chance': spawnChance,
      'avg_spawns': avgSpawns,
      'spawn_time': spawnTime,
      'multipliers': multipliers,
      'weaknesses': weaknesses,
      'next_evolution': nextEvolution?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Pokemon(
      id: map['id'],
      num: map['num'],
      name: map['name'],
      img: map['img'],
      type: List<String>.from(map['type']),
      height: map['height'],
      weight: map['weight'],
      candy: map['candy'],
      candyCount: map['candy_count'],
      egg: map['egg'],
      spawnChance: map['spawn_chance'].toString(),
      avgSpawns: map['avg_spawns'].toString(),
      spawnTime: map['spawn_time'],
      multipliers: List<double>.from(map['multipliers'] ?? []),
      weaknesses: List<String>.from(map['weaknesses']),
      nextEvolution: List<NextEvolution>.from(
          map['next_evolution']?.map((x) => NextEvolution.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source));
}

class NextEvolution {
  String num;
  String name;

  NextEvolution({this.num, this.name});

  Map<String, dynamic> toMap() {
    return {
      'num': num,
      'name': name,
    };
  }

  factory NextEvolution.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NextEvolution(
      num: map['num'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NextEvolution.fromJson(String source) =>
      NextEvolution.fromMap(json.decode(source));
}
