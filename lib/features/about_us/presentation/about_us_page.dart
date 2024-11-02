import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vill_finder/core/env/env.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late InAppWebViewController webViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        await webViewController.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const url = "${Env.apiURL}/about_us/";

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await webViewController.reload();
            },
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
