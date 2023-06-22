import 'package:rick_and_morty_app/data/character.dart';
import 'package:rick_and_morty_app/data/page_info.dart';

class CharactersResponse {
  //объявляем класс и его св-ва
  final PageInfo info;
  //'info' объект класса PageInfo

  final List<Character> results;
  //'results' список объектов из 'Character'

  //конструктор нашего класса
  CharactersResponse({
    required this.info,
    required this.results,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    //объявляем фабричный метод, который принимает json
    final infoJson = json['info'] as Map<String, dynamic>;
    final resultsJson = json['results'] as List<dynamic>;
   

    //извлекаем данные json для свойств 'info' и 'results'

    return CharactersResponse(
      //возвращаем полученные данные
      info: PageInfo.fromJson(infoJson),
      //вызываем метод '.fromJson' класса 'PageInfo' и передаем 'infoJson', чтобы создать объект 'info'
      results: resultsJson
          //для списка используем метод '.map'

          .map((json) => Character.fromJson(json as Map<String, dynamic>))
          .toList(),

      //преобразовываем данные в list
    );
  }
}
