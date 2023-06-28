import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/character_list_screen.dart';
import 'package:rick_and_morty_app/service/api.dart';

final  api = Api();
void main() => runApp(const RickMorty());

class RickMorty extends StatelessWidget {
  const RickMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData.dark(),
      home: const CharacterListScreen(),
    );
  }
}
