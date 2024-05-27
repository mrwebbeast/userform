import "package:flutter/material.dart";
import "package:url_launcher/url_launcher_string.dart";
import "package:webview_flutter/webview_flutter.dart";

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.title, this.url});
  final String? title;
  final String? url;

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  WebViewController controller = WebViewController();

  _launchURL(String url) async {
    try {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );

      debugPrint("Launching $url");
    } catch (e, s) {
      debugPrint("Url Launch Error $e & $s");
    }
  }

  @override
  Future<void> initState() async {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Progress is $progress");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            await _launchURL(request.url);
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? "www.google.com"));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Web Url :- ${widget.url}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "WebView"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading == true) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
