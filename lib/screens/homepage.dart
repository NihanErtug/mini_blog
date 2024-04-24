import 'package:flutter/material.dart';
import 'package:mini_blog/screens/add_blog.dart';
import 'package:mini_blog/screens/data_blog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  _changeTheme(bool value) {
    setState(() {
      themeMode = value ? ThemeMode.dark : ThemeMode.light;

//sync(senkron işlem) -> çalışma zamanının süre olarak ne kadar süreceğini bildiğimiz, cevabın aniden geldiği zamanlar bu kullanılır.

      _writeThemeData(true);
    });
  }

// veri yazmak, veri okumak, http cevabı beklemek ne kadar süreceği belli olmayan durumlardır. böyle durumlardar async(asenkron) işlem yapılır.
// async -> çalıştırıldığında alt satıra geçmeden cevabın gelmesini beklemediğimiz yani işlemi bloklamadığımız işlemler.
// await -> cevabın ne zaman geleceğini bilmiyorum, cevap gelene kadar alt satıra geçmemem, beklemem lazım.

  _writeThemeData(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("DARKTHEME", value);
  }

  */
  Widget _buildBlogItem(Blog blog) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                blog.thumbnail,
                //width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(),
              Text(
                blog.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(blog.author),
              const SizedBox(height: 10),
              Text(blog.content),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Yazıları"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const AddBlog()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Blog>?>(
        future: fetchBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView(
              children:
                  snapshot.data!.map((blog) => _buildBlogItem(blog)).toList(),
            );
          } else {
            return const Center(child: Text("Bilgiler yüklenemedi."));
          }
        },
      ),

      /*
            Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  _changeTheme(value);
                }),
                */
    );
  }
}
