import 'package:animan/controller/StreamingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../component/CardEpisode.dart';

class ShowEpisode extends StatelessWidget {
  const ShowEpisode ({super.key});

  @override
  Widget build(BuildContext context) {
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
    final String? slug = Get.parameters["slug"];
    final streamingController = Get.put(StreamingController());
    streamingController.getStreaming(slug: slug!);
    return SingleChildScrollView(
      child: Container(
        margin:const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
              children: [
                SizedBox(
                    height: 240,
                    child:Obx(() => WebViewWidget(controller: streamingController.webViewController.value))
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
                            onSelected: (bool selected){
                              streamingController.indexIframe.value = index;
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
      
                Container(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  width: MediaQuery.of(context).size.width,
                  child:Obx(() => Text(streamingController.show.value.title as String,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
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
                              margin:EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
                  margin: const EdgeInsets.fromLTRB(10,15,10,0),
                  width: MediaQuery.of(context).size.width,
                  child: Obx(() => Column(
                      children: [

                        ...?streamingController.show.value.episode?.reversed.map((episode) {
                          return CardEpisode(episode: episode);
                        })

                      ],
                    ),
                  ),
                )
      
      
              ],
            )
      ),
    );
  }
}
