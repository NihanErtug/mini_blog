import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;
  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              expandedHeight: 70.0,
              title: Text(blog.title ?? 'Blog Detayı'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.title ?? 'Başlık Yok',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text('Yazar: ${blog.author ?? 'Bilinmiyor'}'),
                        const SizedBox(height: 10),
                        Text(
                            'Yayınlanma Tarihi: ${blog.pubDate ?? 'Bilinmiyor'}'),
                        const SizedBox(height: 20),
                        blog.content != null && blog.content!.isNotEmpty
                            ? Html(data: blog.content)
                            : Text("İçerik Bulunamadı"),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
