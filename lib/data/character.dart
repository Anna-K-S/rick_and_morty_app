import 'package:rick_and_morty_app/data/location.dart';
import 'package:rick_and_morty_app/data/origin.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final List<Origin> origin;
  final List<Location> location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final episodeJson = json['episode'] as List<dynamic>;
    final originJson = json['origin'] as Map<String, dynamic>;
    final locationJson = json['location'] as Map<String, dynamic>;
    

    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: [Origin.fromJson(originJson)].toList(),
      location:[Location.fromJson(locationJson)].toList(),
      image: json['image'] as String,
      episode: episodeJson.map((json) => json as String).toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }
}
