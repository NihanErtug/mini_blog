import 'package:html/parser.dart' as html_parser;
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

String parseHtmlContent(String htmlContent) {
  try {
    final document = html_parser.parse(htmlContent);
    return document.body?.outerHtml ?? "İçerik Bulunamadı";
  } catch (e) {
    print("HTML parse hatası: $e");
    return "İçerik temizlenemedi";
  }
}

String formatDate(String pubDate) {
  try {
    final rfc822Format = DateFormat('EEE, dd MMM yyyy HH:mm:ss z', 'en_US');

    DateTime parsedDate = rfc822Format.parse(pubDate, true).toLocal();

    return DateFormat('EEEE, dd MMMM yyyy', 'en_US').format(parsedDate);
  } catch (e) {
    print('Tarih formatlama hatası: $e');
    return 'Geçersiz Tarih';
  }
}
