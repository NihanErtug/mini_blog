import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:mini_blog/blocs/articles/article_blog.dart';
import 'package:mini_blog/blocs/articles/article_event.dart';
import 'package:mini_blog/blocs/articles/article_state.dart';
import 'package:mini_blog/models/blog.dart';
import 'package:mini_blog/screens/blog_detail_page.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBlog, ArticleState>(
      builder: (context, state) {
        if (state is ArticlesNotLoaded) {
          context.read<ArticleBlog>().add(FetchArticles());
          return Center(
            child: Text("Blog yükleme işlemi başlamadı."),
          );
        }
        if (state is ArticlesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AtriclesLoadFail) {
          return Center(
            child: Text("Bloglar yüklenirken hata oluştu."),
          );
        }
        if (state is ArticlesLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) =>
                      _buildBlogItem(state.blogs[index]),
                ),
              ),
            ],
          );
        }
        return Center(
          child: Text("Bilinmeyen durum"),
        );
      },
    );
  }

  Widget _buildBlogItem(Blog blog) {
    Color borderColor = Theme.of(context).colorScheme.primary;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.title ?? 'Başlık bulunamadı',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(blog.author ?? 'Yazar bilgisi yok'),
            const SizedBox(height: 10),
            Text(blog.pubDate ?? 'Tarih bilgisi yok'),
            const SizedBox(height: 10),
            blog.content != null &&
                    blog.content!.isNotEmpty &&
                    blog.content!.length > 100
                ? Html(data: blog.content!.substring(0, 100))
                : Text("İçerik bulunamadı"),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlogDetailPage(blog: blog)));
              },
              child: Text("Devamını oku"),
            ),
          ],
        ),
      ),
    );
  }
}
