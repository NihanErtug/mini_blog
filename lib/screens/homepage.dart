import 'package:flutter/material.dart';

import 'package:mini_blog/screens/add_blog.dart';
import 'package:mini_blog/screens/blog_list.dart';

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

// veri yazmak, veri okumak, http cevabı beklemek ne kadar süreceği belli olmayan durumlardır. böyle durumlarda async(asenkron) işlem yapılır.
// async -> çalıştırıldığında alt satıra geçmeden cevabın gelmesini beklemediğimiz yani işlemi bloklamadığımız işlemler.
// await -> cevabın ne zaman geleceğini bilmiyorum, cevap gelene kadar alt satıra geçmemem, beklemem lazım.

  _writeThemeData(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("DARKTHEME", value);
  }

  */

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
      body: const BlogList(),

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
