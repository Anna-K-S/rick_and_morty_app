import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/main.dart';
import 'package:rick_and_morty_app/service/api.dart';
import 'package:rick_and_morty_app/service/item_status.dart';
import 'package:rick_and_morty_app/theme/text_styles.dart';

class CharacterDetailScreen extends StatefulWidget {
  //класс с подробной информацией о персонаже
  final int characterId;
//в качестве обязательного параметра принимает id персонажа
  const CharacterDetailScreen({required this.characterId, super.key});
  //конструктор

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  //экземпляр класса Api для запросов
  final _icon = ItemStatus();
  //экземпляр класса ItemStatus для получения соответствующей иконки статуса персонажа

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Detail'),
      ),
      body: FutureBuilder(
        future: api.getDetailsCharacters(widget.characterId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            //проверка на ошибку в полученных данных
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData)
          // проверка поступили ли данные
          {
            final character = snapshot.data!;
            //полученные данные о персонажах

            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.network(
                    //отображение изображение прешедшего в виде ссылки из _character.image
                    character.image,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(character.name,
                            style: AppTextStyles.characterName),
                        Text(
                          '${_icon.getItemStatus(character.status)} - ${character.species} ${_icon.getItemIcon(_icon.getItemStatus(character.status))}',
                          style: AppTextStyles.status,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Last know location:',
                            style: AppTextStyles.text),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                character.location.first.name,
                                style: AppTextStyles.lastLocation,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('First seen in:',
                                  style: AppTextStyles.text),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                character.origin.first.name,
                                style: AppTextStyles.firstLocation,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Episodes:',
                                  style: AppTextStyles.text),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                character.episode.first,
                                style: AppTextStyles.episodes,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Text('data');
        },
      ),
    );
  }
}
