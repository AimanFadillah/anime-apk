import 'dart:convert';

import 'package:animan/model/Streaming.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:animan/model/LinkIframe.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamingController extends GetxController {
  Rx<WebViewController> webViewController = Rx<WebViewController>(WebViewController());
  RxString linkStreaming = RxString("");
  Rx<Streaming> show = Rx<Streaming>(
    Streaming(
      title: "",
      slug: "",
      image: "",
      synopsis: "",
      genre: [],
      episode: [],
      downloads: null,
      iframe: [],
    )
  );

  getStreaming ({required String slug}) async {
    try{
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/episode/$slug"));
      show.value = Streaming.fromJson(jsonDecode(response.body));
      final data = show.value.iframe?[show.value.iframe!.length - 4];
      final responseIframe =  await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/iframe?post=${data?.post}&nume=${data?.nume}"));
      final LinkIframe jsonIframe = LinkIframe.fromJson(jsonDecode(responseIframe.body));
      linkStreaming.value = jsonIframe.iframe!;
      webViewController.value
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(linkStreaming.value));
    }catch(e){
      print(e);
    }
  }


}