import 'package:rick_and_morty_app/data/character.dart';
import 'package:rick_and_morty_app/data/page_info.dart';

//объявляем класс и его св-ва
class CharactersResponse {
  //'info' объект класса PageInfo
  final PageInfo info;

//'results' список объектов из 'Character'
  final List<Character> results;

  //конструктор нашего класса
  CharactersResponse({
    required this.info,
    required this.results,
  });
//объявляем фабричный метод, который принимает json
  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    //извлекаем данные json для свойств 'info' и 'results'
    final infoJson = json['info'] as Map<String, dynamic>;
    final resultsJson = json['results'] as List<dynamic>;

//возвращаем полученные данные
    return CharactersResponse(
      //вызываем метод '.fromJson' класса 'PageInfo' и передаем 'infoJson', чтобы создать объект 'info'
      info: PageInfo.fromJson(infoJson),
      results: resultsJson
          //для списка используем метод '.map'
          .map((json) => Character.fromJson(json as Map<String, dynamic>))
          //преобразовываем данные в list
          .toList(),
    );
  }
}
