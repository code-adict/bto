import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Btowebview extends StatefulWidget {
  const Btowebview({super.key});

  @override
  State<Btowebview> createState() => _BtowebviewState();
}

class _BtowebviewState extends State<Btowebview> {
  late WebViewController controller;
  bool isLoading = true;
  double progress = 0.0;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              progress = 0.0;
            });
          },
          onProgress: (int value) {
            setState(() {
              progress = value / 100;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Error: ${error.description}");
            setState(() {
              _errorMessage = _getErrorMessage(error);
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.facebook.com/')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Blocked'),
                  content: const Text('Sharing to facebook is not allowed.\n '
                      'Visit the website to use this features'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://x.com')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Blocked'),
                  content: const Text('Sharing to X is not allowed.\n '
                      'Visit the website to use this features'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://pinterest.com')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Blocked'),
                  content: const Text('Sharing to Pinterest is not allowed.\n '
                      'Visit the website to use this features'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://www.linkedin.com')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Blocked'),
                  content: const Text('Sharing to LinkedIn is not allowed.\n '
                      'Visit the website to use this features'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://telegram.me/')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Blocked'),
                  content: const Text('Sharing to Telegram is not allowed.\n '
                      'Visit the website to use this features'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://bontonoutfitters9ja.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                }
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Bon Ton Outfitters9ja',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.reload(),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          if (_errorMessage.isEmpty)
            RefreshIndicator(
              onRefresh: () async {
                await controller.reload();
              },
              child: Stack(
                children: [
                  WebViewWidget(
                    controller: controller,
                  ),
                  if (progress < 1.0)
                    LinearProgressIndicator(
                      value: progress,
                      color: Colors.blue,
                      backgroundColor: Colors.grey[200],
                    ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            )
          else
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _errorMessage = '';
                      });
                      controller.reload();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Maps WebResourceError to user-friendly error messages
  String _getErrorMessage(WebResourceError error) {
    if (error.errorCode == -2) {
      return 'Unable to reach the server. Please check your internet connection.';
    } else if (error.errorCode == -8) {
      return 'The server is taking too long to respond. Please try again later.';
    } else if (error.errorCode >= 400 && error.errorCode < 500) {
      return 'A client error occurred (${error.errorCode}). Please try again.';
    } else if (error.errorCode >= 500) {
      return 'The server encountered an issue (${error.errorCode}). We are working to resolve it.';
    } else {
      return 'An unexpected error occurred: ${error.description}';
    }
  }
}
