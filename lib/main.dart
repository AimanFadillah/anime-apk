import 'package:animan/component/CardAnime.dart';
import 'package:animan/component/CardEpisode.dart';
import 'package:animan/component/PlaceHolderCard.dart';
import 'package:animan/component/PlaceHolderEpisode.dart';
import 'package:animan/controller/AnimeController.dart';
import 'package:animan/controller/EpisodeController.dart';
import 'package:animan/page/ShowEpisode.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main () {
  if (WebViewPlatform.instance == null) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    }
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Setel latar belakang status bar jadi putih
    statusBarIconBrightness: Brightness.dark, // Ikon status bar jadi hitam
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  runApp(
    GetMaterialApp(
      title: "Homepage",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const MyApp()),
        GetPage(name: "/episode/:slug", page:() => const ShowEpisode())
      ],
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
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          indexPage.value = index;
        },
        children: pages,
      ),
      bottomNavigationBar: Obx(() => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFF87A2FF),
          selectedIndex: indexPage.value,
          onDestinationSelected: (int index) {
            indexPage.value = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
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
    return Container(
      margin: const EdgeInsets.fromLTRB(0,30,0,0),
      child: Obx(() => LazyLoadScrollView(
        onEndOfPage: () => episodeController.getEpisodeMore(),
        isLoading: episodeController.loadingStop.value,
        scrollOffset: 2300,
        child: ListView(
          padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          key: const PageStorageKey<String>("MyEpisodeGrid"),
          children: [
            ...episodeController.listEpisode.map((episode) {
              return CardEpisode(episode: episode,onTap: () {
                Get.toNamed("/episode/${episode.slug}");
              });
            }),

            if(!episodeController.loadingStop.value) ...List.generate(10, (index) {
              return const PlaceHolderEpisode();
            }),

          ],
        ),
      ),
      ),
    );
  }
}

