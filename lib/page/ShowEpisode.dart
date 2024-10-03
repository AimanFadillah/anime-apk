import 'package:animan/controller/StreamingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowEpisode extends StatelessWidget {
  const ShowEpisode ({super.key});

  @override
  Widget build(BuildContext context) {
    final String? slug = Get.parameters["slug"];
    final streamingController = Get.put(StreamingController());
    streamingController.getStreaming(slug: slug!);
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => SizedBox(
          height: 200,
          child:WebViewWidget(controller: streamingController.webViewController.value)
        )
      ),
    );
  }
}
