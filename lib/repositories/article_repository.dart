import 'package:http/http.dart' as http;
import 'package:mini_blog/models/blog.dart';
import 'dart:convert';

// article nesnesine ulaşmayı sağlayacak metotları içeren class'ımız bu

class ArticleRepository {
  Future<List<Blog>> fetchAll() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    final response = await http.get(url);

    final jsonData = jsonDecode(response.body) as List;

    return jsonData.map((e) => Blog.fromJson(e)).toList();
  }
}
