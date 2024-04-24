import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<List<Blog>?> fetchBlogs() async {
  try {
    final response = await http
        .get(Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      final blogs = jsonData.map((e) => Blog.fromJson(e)).toList();
      return blogs;
    } else {
      //return null;
      throw Exception("Blog yüklenemedi! HTTP kodu: ${response.statusCode}");
    }
  } catch (error) {
    //return null;
    throw Exception("Blog yüklenirken bir hata oluştu: $error");
  }
}

class Blog {
  String id;
  String title;
  String content;
  String thumbnail;
  String author;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.author,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        thumbnail: json["thumbnail"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "tumbnail": thumbnail,
        "author": author,
      };
}
