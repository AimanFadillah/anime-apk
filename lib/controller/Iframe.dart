// import 'package:flutter/material.dart';
//
// class Iframe extends StatelessWidget {
//   final String slug;
//   const Iframe({required this.slug,super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text("hello word");
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class Iframe extends StatefulWidget {
//   final String link;
//   const Iframe({required this.link, super.key});
//
//   @override
//   State<Iframe> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<Iframe> {
//   late final WebViewController webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.link));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(controller: webViewController);
//   }
// }
