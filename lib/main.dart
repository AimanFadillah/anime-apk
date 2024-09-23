import 'package:animan/controller/AnimeController.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

void main () {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Setel latar belakang status bar jadi putih
    statusBarIconBrightness: Brightness.dark, // Ikon status bar jadi hitam
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  runApp(
    SafeArea(child:
      GetMaterialApp(
        title: "Homepage",
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => const MyApp())
        ],
      )
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: MyBody(),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final animeController = Get.put(AnimeController());
    return Container(
      margin: const EdgeInsets.fromLTRB(0,20,0,0),
      child: Obx(() => animeController.is_loading.value ?
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
          children: List.generate(10, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!, // Warna dasar
                      highlightColor: Colors.white, // Warna highlight
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey[300], // Warna background placeholder
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ) :
        GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
            children:animeController.listAnime.map((anime) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: CardAnime(nama: anime.title as String, image: anime.image as String)),
                ],
              );
            }).toList(),
        ),
      ),
    );
  }
}

String truncateText(String text, {int cutoff = 20}) {
  if (text.length <= cutoff) {
    return text;
  } else {
    return '${text.substring(0, cutoff)}...';
  }
}

class CardAnime extends StatelessWidget {
  final String nama;
  final String image;
  const CardAnime({required this.nama,required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // boxShadow: [
        //   BoxShadow(
        //     // color: Colors.black.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Image.network(
              image,
              // fit: BoxFit.cover, // Isi sesuai kontainer
              // height: MediaQuery.of(context).size.height * 0.288,
              // loadingBuilder: (context,child,loadingProgress){
              //   if (loadingProgress == null) return child;
              //   return Container(
              //     padding: EdgeInsets.symmetric(),
              //     child: Shimmer.fromColors(
              //       baseColor: Colors.grey[300]!, // Warna dasar
              //       highlightColor: Colors.white, // Warna highlight
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: Colors.grey[300], // Warna background placeholder
              //         ),
              //       ),
              //     ),
              //   );
              // },
            ),
            Positioned(
              bottom: 0, // Posisi teks di bawah gambar
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Text(
                  truncateText(nama,cutoff: 17),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}