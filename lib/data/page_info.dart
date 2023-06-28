class PageInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  PageInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

 
}
