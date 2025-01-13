import 'dart:convert';

class Noticias {
  String status;
  int totalResults;
  List<Article> articles;

  Noticias({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory Noticias.fromJson(String str) => Noticias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Noticias.fromMap(Map<String, dynamic> json) => Noticias(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
      };
}

class Article {
  Map<String, dynamic>? source;
  String? author;
  String title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: json["source"],
        author: json["author"],
        title: json["title"] ?? "Sin título",
        description: _cleanTruncatedText(json["description"]),
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] != null ? DateTime.parse(json["publishedAt"]) : null,
        content: _cleanTruncatedText(json["content"]),
      );

  static String? _cleanTruncatedText(String? text) {
    if (text == null) return null;
    // Elimina "... [+123 chars]" o "...[+123 chars]"
    return text.replaceAll(RegExp(r'\.\.\.\s?\[\+\d+\s?chars\]'), '');
  }

  Map<String, dynamic> toMap() => {
        "source": source,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}
