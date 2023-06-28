import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/data/characters_response.dart';

import '../data/character.dart';

const _basePath = 'https://rickandmortyapi.com/api';
//объявление константы, которая содержит базовую ссылку для API

class Api {
  //объявление класса Api
  final Dio _dio = Dio(
    //создание экземпляра класса
    //Dio - http-клиент для отправки сетевых запросов
    BaseOptions(
      baseUrl: _basePath,
      //передаем базовую ссылку клиента
    ),
  );

  Future<CharactersResponse> getCharacters() async {
    //создаем асинхронный метод, который возвращает 'CharactersResponse'
    final response = await _dio.get('/character');
    //создаем GET запрос к endpoint '/character'

    if (response.statusCode != 200) throw Exception('error status code');
    //проверка статус-кода ответа на запрос

    final json = response.data as Map<String, dynamic>;
    //приводим данные response.data к Map<String, dynamic>;
    final result = CharactersResponse.fromJson(json);
    //с помощью метода '.fromJson'  y 'CharactersResponse' получаем данные из 'json'
    return result;
    //возвращаем результат метода 'getCharacter'
  }

  Future<Character> getDetailsCharacters(int id) async {
    //создаем асинхронный метод, который возвращаем 'Character' и принимает 'id'
    final response = await _dio.get('/character/$id');
    //создаем GET запрос к endpoint '/character/$id', чтобы получить инфо о персонаже с указанным id

    if (response.statusCode != 200) throw Exception('error status code');
//проверка статус кода
    final json = response.data as Map<String, dynamic>;
//приводим данные response.data к Map<String, dynamic>;
    final result = Character.fromJson(json);

    return result;
  }
 
}
