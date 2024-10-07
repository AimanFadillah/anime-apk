import 'dart:convert';

import 'package:animan/model/Streaming.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:animan/model/LinkIframe.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamingController extends GetxController {
  Rx<WebViewController> webViewController = Rx<WebViewController>(WebViewController());
  RxString linkStreaming = RxString("");
  RxInt indexIframe = RxInt(0);
  RxBool isLoadingIframe = RxBool(false);
  Rx<Streaming> show = Rx<Streaming>(
    Streaming(
      anime: "",
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
      indexIframe.value = 0;
      show.value = Streaming.fromJson(jsonDecode(response.body));
      getIframe(index:indexIframe.value);
    }catch(e){
      print(e);
    }
  }

  getIframe ({required int index}) async {
    try{
      if(isLoadingIframe.value == true) {
        return;
      }
      isLoadingIframe.value = true;
      indexIframe.value = index;
      final data = show.value.iframe?[index];
      final responseIframe =  await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/iframe?post=${data?.post}&nume=${data?.nume}"));
      final LinkIframe jsonIframe = LinkIframe.fromJson(jsonDecode(responseIframe.body));
      final linkStreaming = jsonIframe.iframe!;
      webViewController.value
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(false)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              isLoadingIframe.value = false;
              webViewController.value.runJavaScript(
                  """
                document.addEventListener('fullscreenchange', function(e) {
                  if (document.fullscreenElement) {
                    FlutterChannel.postMessage('fullscreen');
                  }else{
                    FlutterChannel.postMessage('fullscreen_no');
                  }
                });
                """
              );
            },
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.prevent;
            },
          ),
        )..addJavaScriptChannel("FlutterChannel", onMessageReceived: (JavaScriptMessage server) {
          if(server.message == "fullscreen"){
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeLeft,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          }

          if(server.message == "fullscreen_no"){
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

          }
        })
        ..loadRequest(Uri.parse(linkStreaming));
    }catch(e){
      print(e);
    }
  }


}