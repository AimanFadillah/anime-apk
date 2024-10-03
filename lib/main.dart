import 'package:animan/component/CardAnime.dart';
import 'package:animan/component/CardEpisode.dart';
import 'package:animan/component/PlaceHolderCard.dart';
import 'package:animan/component/PlaceHolderEpisode.dart';
import 'package:animan/controller/AnimeController.dart';
import 'package:animan/controller/EpisodeController.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';

void main () {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFC4D7FF), // Setel latar belakang status bar jadi putih
    statusBarIconBrightness: Brightness.dark, // Ikon status bar jadi hitam
    systemNavigationBarColor: Color(0xFF87A2FF),
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
    final List<Widget> pages = [const MyEpisode(),const MyAnime()];
    final PageController pageController = PageController();
    return Scaffold(
      backgroundColor: const  Color(0xFFC4D7FF),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          indexPage.value = index;
        },
        children: pages,
      ),
      bottomNavigationBar: Obx(() => NavigationBar(
          backgroundColor: const Color(0xFF87A2FF),
          selectedIndex: indexPage.value,
          onDestinationSelected: (int index) {
            indexPage.value = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          indicatorColor: Colors.white,
          destinations:const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Episode',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Anime',
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
      child: Obx(() =>
      LazyLoadScrollView(
        onEndOfPage: () => animeController.getAnimesMore(),
        scrollOffset: 1300,
        isLoading: animeController.loadingStop.value,
          child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
          key: const PageStorageKey<String>('myAnimeGrid'),
          children:[
            ...animeController.listAnime.map((anime) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: CardAnime(anime: anime)),
                ],
              );
            }),
            if(!animeController.loadingStop.value) ...List.generate(10, (index) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: PlaceHolderCard()),
                  ],
                );
            })
          ],
        ),
      ),
    ));
  }
}

class MyEpisode extends StatelessWidget {
  const MyEpisode({super.key});

  @override
  Widget build(BuildContext context) {
    final episodeController = Get.put(EpisodeController());
    return Obx(() => LazyLoadScrollView(
      onEndOfPage: () => episodeController.getEpisodeMore(),
      isLoading: episodeController.loadingStop.value,
      scrollOffset: 2300,
      child: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        key: const PageStorageKey<String>("MyEpisodeGrid"),
        children: [
          ...episodeController.listEpisode.map((episode) {
            return CardEpisode(episode: episode);
          }),

          if(!episodeController.loadingStop.value) ...List.generate(10, (index) {
            return const PlaceHolderEpisode();
          }),

        ],
      ),
    ),
    );
  }
}

