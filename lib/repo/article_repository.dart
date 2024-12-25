import 'package:mini_blog/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:mini_blog/utils.dart';
import 'package:xml/xml.dart' as xml;

class ArticleRepository {
  Future<List<Blog>> fetchAll() async {
    final url = 'https://medium.com/feed/@ertugnihan';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      // RSS item'larını Blog nesnesine dönüştürme işlemi
      return items.map((item) {
        final title = item.findElements('title').isNotEmpty
            ? item.findElements('title').single.innerText
            : "Başlık Yok";
        final link = item.findElements('link').isNotEmpty
            ? item.findElements('link').single.innerText
            : "Bağlantı Yok";
        final content = item.findElements('content:encoded').isNotEmpty
            ? parseHtmlContent(
                item.findElements('content:encoded').single.innerText)
            : "İçerik Yok";
        final pubDateElement = item.findAllElements('pubDate').isNotEmpty
            ? item.findElements('pubDate').first
            : null;
        final pubDate = pubDateElement != null
            ? formatDate(pubDateElement.innerText.trim())
            : "Tarih Yok";
        final author = item.findElements('dc:creator').isNotEmpty
            ? item.findElements('dc:creator').single.innerText
            : "Yazar Yok";

        // Blog sınıfına döndürme
        return Blog(
          id: link,
          title: title,
          content: content,
          pubDate: pubDate,
          author: author,
        );
      }).toList();
    } else {
      throw Exception('RSS feed alınamadı: ${response.statusCode}');
    }
  }
}
