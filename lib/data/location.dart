class Location {
  final String name;
  final String url;
  

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) 
  //фабричный метод, который создает экземпляр класса на основе полученных данных из JSON
  // метод, преобразующий JSON-объект в экземпляр класса Location
  {
    return Location(
      name: json['name'] as String,
      url: json['url'] as String,
      //закастили данные 
    );
  }
}