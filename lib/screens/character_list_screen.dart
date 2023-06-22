import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/service/api.dart';
import 'package:rick_and_morty_app/data/characters_response.dart';
import 'package:rick_and_morty_app/service/item_status.dart';
import 'package:rick_and_morty_app/theme/text_styles.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  //приватный класс
  final Api _api = Api();
  //экземпляр класса Api
  final _icon = ItemStatus();
  //экземпляр класса ItemStatus

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //создание базовой структуры экрана
      appBar: AppBar(
        title: const Text('Characters'),
        //заголовок вверху экрана с текстом
      ),

      body: SafeArea(
        child: FutureBuilder(
            future: _api.getCharacters(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
                //отображает данные полученные из будущего функции "_api.getCharacters()"
                //и показывает индикатор загрузки "CircularProgressIndicator();"
                //ConnectionState позволяет определить состояние асинхронной операции
                //ConnectionState.waiting - операция выполняется в данный момент
              }
              if (snapshot.hasError) {
                Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              final CharactersResponse _data = snapshot.data;

              return ListView.builder(
                  //отображает список персонажей с использованием данных из snapshot.data
                  itemCount: _data.results
                      .length, //количество элементов в получаемом списке
                  itemBuilder: (BuildContext context, int index) {
                    final _item = _data.results[index];
                    //получаем элементов по индексу

                    return ListTile(
                      //отображает каждый элемент списка персонажей
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            _item.image,
                            height: 150.0,
                            width: 150.0,
                            alignment: Alignment.centerLeft,
                          ),
                          const SizedBox(
                              width:
                                  5), //небольшой отступ между изображением и текстом
                          Expanded(
                            child: Column(
                              //вертикальное отображение элементов
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_item.name,
                                    style: AppTextStyles.characterName),
                                Text(
                                  '${_icon.itemIcon(_item.status)} ${_item.status} - ${_item.species}',
                                  style: AppTextStyles.status,
                                ),
                                const Text('Last know location: ',
                                    style: AppTextStyles.text),
                                Text(
                                  _item.location[0].name,
                                  maxLines: 1,
                                  //ограничение количества строк для расположения и места первого появления,
                                  // чтобы они не занимали много места
                                  style: AppTextStyles.lastLocation,
                                ),
                                const Text(
                                  'First seen in',
                                  style: AppTextStyles.text,
                                ),
                                Text(
                                  _item.origin[0].name,
                                  maxLines: 1,
                                  style: AppTextStyles.firstLocation,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(
                              characterId: _data.results[index].id),
                          //переход на след экран с детальной информацией о персонаже
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
