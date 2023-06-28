import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/characters_response.dart';
import 'package:rick_and_morty_app/service/item_status.dart';
import 'package:rick_and_morty_app/theme/text_styles.dart';
import '../main.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

//приватный класс
class _CharacterListScreenState extends State<CharacterListScreen> {
//экземпляр класса ItemStatus
  final _icon = ItemStatus();

  @override
  Widget build(BuildContext context) {
    //создание базовой структуры экрана
    return Scaffold(
      //заголовок вверху экрана с текстом
      appBar: AppBar(
        title: const Text('Characters'),
      ),

      body: SafeArea(
        child: FutureBuilder<CharactersResponse>(
            //отображает данные полученные из будущего функции "_api.getCharacters()"
            future: api.getCharacters(),
            builder: (context, snapshot) {
              //ConnectionState позволяет определить состояние асинхронной операции
              //ConnectionState.waiting - операция выполняется в данный момент
              if (snapshot.connectionState == ConnectionState.waiting) {
                //и показывает индикатор загрузки "CircularProgressIndicator();"
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError || snapshot.data == null) {
                Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              final _data = snapshot.data;
              //отображает список персонажей с использованием данных из snapshot.data
              return ListView.builder(
                  //количество элементов в получаемом списке
                  itemCount: _data!.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    //получаем элементов по индексу
                    final item = _data.results[index];

                    //отображает каждый элемент списка персонажей
                    return ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Ink.image(
                            height: 150.0,
                            width: 150.0,
                            alignment: Alignment.centerLeft,
                            image: NetworkImage(item.image),
                          ),
                          //небольшой отступ между изображением и текстом
                          const SizedBox(width: 5),
                          Expanded(
                            //вертикальное отображение элементов
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.name,
                                    style: AppTextStyles.characterName),
                                Text(
                                  '${_icon.getItemIcon(_icon.getItemStatus(item.status))} ${item.status} - ${item.species}',
                                  style: AppTextStyles.status,
                                ),
                                const Text('Last know location: ',
                                    style: AppTextStyles.text),
                                Text(
                                  item.location.first.name,
                                  //ограничение количества строк для расположения и места первого появления,
                                  // чтобы они не занимали много места
                                  maxLines: 1,
                                  style: AppTextStyles.lastLocation,
                                ),
                                const Text(
                                  'First seen in',
                                  style: AppTextStyles.text,
                                ),
                                Text(
                                  item.origin.first.name,
                                  maxLines: 1,
                                  style: AppTextStyles.firstLocation,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //переход на след экран с детальной информацией о персонаже
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(
                              characterId: _data.results[index].id),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
