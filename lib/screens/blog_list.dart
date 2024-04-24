import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/blocs/articles/article_blog.dart';
import 'package:mini_blog/blocs/articles/article_event.dart';
import 'package:mini_blog/blocs/articles/article_state.dart';
import 'package:mini_blog/models/blog.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    // hangi blogu ve state'i kullanmak istediğimizi istiyor BlocBuilder
    return BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
      if (state is ArticlesNotLoaded) {
        context.read<ArticleBloc>().add(FetchArticles());
        return const Center(
          child: Text("Blog yükleme işlemi başlamadı.."),
        );
      }

      if (state is ArticlesLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is ArticlesLoadFail) {
        return const Center(
          child: Text("Blogların yüklenmesinde hata oluştu.."),
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
      return const Center(child: Text("Bilinmedik durum.."));
    });
  }

  Widget _buildBlogItem(Blog blog) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                blog.thumbnail!,
                //width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                blog.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(blog.author!),
              const SizedBox(height: 10),
              Text(blog.content!),
            ],
          ),
        ),
      ),
    );
  }
}
