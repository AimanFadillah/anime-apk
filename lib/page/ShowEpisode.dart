import 'dart:math';

import 'package:animan/component/CardAnime.dart';
import 'package:animan/controller/StreamingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../component/CardEpisode.dart';

class ShowEpisode extends StatelessWidget {
  const ShowEpisode ({super.key});

  @override
  Widget build(BuildContext context) {
    final String? slug = Get.parameters["slug"];
    final streamingController = Get.put(StreamingController());
    streamingController.getStreaming(slug: slug!);
    return const Scaffold(
      backgroundColor: Colors.white,
      body:MyStreaming()
    );
  }
}

class MyStreaming extends StatelessWidget {
  const MyStreaming ({super.key});

  @override
  Widget build(BuildContext context) {
    final streamingController = Get.put(StreamingController());
    ScrollController scrollController = ScrollController();
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        margin:const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
              children: [

                Obx(() => Stack(
                  children: [
                    SizedBox(
                      height: 240,
                      child: WebViewWidget(controller: streamingController.webViewController.value),
                    ),
                    if (streamingController.isLoadingIframe.value)
                      Container(
                        color: Colors.black,
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF87A2FF),
                          ),
                        ),
                      ),
                    ],
                  )
                ),



                Obx(() =>
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(streamingController.show.value.iframe!.length,(index) {
                        final quality = streamingController.show.value.iframe![index];
                        final selected = index == streamingController.indexIframe.value;
                        return Container(
                          margin:const EdgeInsets.symmetric(horizontal: 5),
                          child: ChoiceChip(
                            padding:const EdgeInsets.all(1),
                            selected:selected,
                            backgroundColor: Colors.white,
                            onSelected: (bool selected){
                              streamingController.getIframe(index: index);
                            },
                            selectedColor:const Color(0xFF87A2FF),
                            showCheckmark: false,
                            label: Text(quality.title as String),
                            labelStyle:const TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Ubah angka ini biar makin buled
                            ),
                          ),
                        );
                      }),
                    )
                  ),
                ),
      
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ExpansionTile(
                    childrenPadding: const EdgeInsets.fromLTRB(10,0,10,10),
                    tilePadding: const EdgeInsets.fromLTRB(10,0,10,0),
                    minTileHeight: 0,
                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    collapsedShape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    showTrailingIcon: false,
                    title: Obx(() => Text(streamingController.show.value.title as String,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFBDBDBD),
                        ),
                        child: Obx(() => Text(streamingController.show.value.synopsis as String,style: TextStyle(fontSize: 12))),
                      )
                    ],
                  ),
                  // child:Obx(() => Text(streamingController.show.value.title as String,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                ),
      
                Container(
                  margin: const EdgeInsets.fromLTRB(5,0,0,0),
                  width: MediaQuery.of(context).size.width,
                  child:Obx(() =>
                      Wrap(
                        children: [
                          ...?streamingController.show.value.genre?.map((gen) {
                            return Container(
                              padding:const EdgeInsets.symmetric(horizontal: 5),
                              margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Text(gen.title as String,style: const TextStyle(fontSize: 12)),
                            );
                          })
                        ],
                      ),
                    ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(10,20,10,0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Membuat border berbentuk lingkaran
                              border: Border.all(
                                color: Colors.black, // Warna border
                                width: 0.8,        // Lebar border
                              ),
                            ),
                            child: ClipOval(
                                child:Obx(() => streamingController.show.value.image != "" ?
                                    Image.network(streamingController.show.value.image as String,
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ) :
                                    const Opacity(
                                      opacity: 0,
                                    ),
                                ),
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() =>
                              Text(truncateText(streamingController.show.value.anime as String,cutoff: 28),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Obx(() => streamingController.show.value.title != "" ?
                        ChoiceChip(
                          padding:const EdgeInsets.all(1),
                          selected:true,
                          backgroundColor: Colors.white,
                          onSelected: (bool selected){
                          },
                          selectedColor:const Color(0xFF87A2FF),
                          showCheckmark: false,
                          label:const Text("Show Anime"),
                          labelStyle:const TextStyle(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Ubah angka ini biar makin buled
                          ),
                        ) :
                        const Opacity(opacity: 0),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(10,15,10,0),
                  width: MediaQuery.of(context).size.width,
                  child: Obx(() {
                    final filteredEpisodes = streamingController.show.value.episode
                        ?.where((episode) =>
                    episode.slug != Get.parameters["slug"] &&
                        episode.slug != streamingController.show.value.previousStreaming &&
                        episode.slug != streamingController.show.value.nextStreaming)
                        .toList();

                    filteredEpisodes?.shuffle(Random());

                    void changeEpisode (String slug) {
                      Get.parameters["slug"] = slug;
                      streamingController.getStreaming(slug: slug);
                      scrollController.jumpTo(0);
                    }

                    return Column(
                      children: [
                        ...?streamingController.show.value.episode?.where((episode) => episode.slug == streamingController.show.value.nextStreaming).map((episode) {
                            return CardEpisode(episode: episode,onTap:() {
                              changeEpisode(episode.slug as String);
                            });
                        }),

                        ...?streamingController.show.value.episode?.where((episode) => episode.slug == streamingController.show.value.previousStreaming).map((episode) {
                            return CardEpisode(episode: episode,onTap:() {
                              changeEpisode(episode.slug as String);
                            });
                        }),

                        ...?filteredEpisodes?.map((episode) {
                          return CardEpisode(episode: episode,onTap:() {
                            changeEpisode(episode.slug as String);
                          });
                        }),
                      ],
                    );
                  }),
                )
              ],
            )
      ),
    );
  }
}
