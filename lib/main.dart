import 'package:animan/component/CardAnime.dart';
import 'package:animan/component/PlaceHolderCard.dart';
import 'package:animan/controller/AnimeController.dart';
import 'package:animan/model/Anime.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:flutter/services.dart';

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
    final RxInt indexPage = RxInt(0);
    final List<Widget> pages = [MyAnime(), MyEpisode()];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => pages[indexPage.value]),
      bottomNavigationBar: Obx(() => NavigationBar(
          selectedIndex: indexPage.value,
          onDestinationSelected: (int index) {
            indexPage.value = index;
          },
          animationDuration: Duration(seconds: 10),
          indicatorColor: Colors.amber,
          destinations:const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}

class MyAnime extends StatelessWidget {
  const MyAnime({super.key});

  @override
  Widget build(BuildContext context) {
    final animeController = Get.put(AnimeController());
    return Container(
      margin: const EdgeInsets.fromLTRB(0,20,0,0),
      child: Obx(() => animeController.isLoading.value ?
      GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        childAspectRatio: 0.8,
        key: const PageStorageKey<String>('myAnimeGrid'),
        children: List.generate(10, (index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: PlaceHolderCard()),
            ],
          );
        }),
      ) :
      GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        childAspectRatio: 0.8,
        key: const PageStorageKey<String>('myAnimeGrid'),
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

class MyEpisode extends StatelessWidget {
  const MyEpisode({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("hello Word"),
    );
  }
}

