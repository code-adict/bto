import 'package:flutter/material.dart';
import 'package:btoapp/view/btowebview.dart';
void main() {
  runApp(const BTOApp());
}

class BTOApp extends StatelessWidget {
  const BTOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Btowebview(),
    );
  }
}

// class WebviewDemo extends StatefulWidget {
//   const WebviewDemo({super.key});
//
//   @override
//   State<WebviewDemo> createState() => _WebviewDemoState();
// }
//
// class _WebviewDemoState extends State<WebviewDemo> {
//   late WebViewController controller;
//   bool isLoading = true;
//   double progress = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             setState(() {
//               isLoading = true;
//               progress = 0.0;
//             });
//           },
//           onProgress: (int value) {
//             setState(() {
//               progress = value / 100;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint("Error: ${error.description}");
//
//             controller.loadHtmlString(
//               '''
//               <html lang="en">
//                 <head>
//                   <title>Offline</title>
//                 </head>
//                 <body style="text-align:center; margin-top:50px;">
//                   <h1>You're Offline</h1>
//                   <h2>Please check your internet connection and try again.</h2>
//                 </body>
//               </html>
//               ''',
//             );
//           },
//
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Blocked'),
//                   content: const Text('Navigation to YouTube is not allowed.'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://bontonoutfitters9ja.com'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Bon Ton Outfitters'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () async {
//               if (await controller.canGoBack()) {
//                 controller.goBack();
//               }
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_forward),
//             onPressed: () async {
//               if (await controller.canGoForward()) {
//                 controller.goForward();
//               }
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => controller.reload(),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await controller.reload();
//         },
//         child: Stack(
//           children: [
//             WebViewWidget(
//               controller: controller,
//             ),
//             if (progress < 1.0)
//               LinearProgressIndicator(
//                 value: progress,
//                 color: Colors.blue,
//                 backgroundColor: Colors.grey[200],
//               ),
//             if (isLoading)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
