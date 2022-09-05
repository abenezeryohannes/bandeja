import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/core/widgets/loading.bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    } else {
      WebView.platform = CupertinoWebView();
    }
  }

  bool loading = true;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.grey.shade50,
              snap: false,
              floating: false,
              expandedHeight: 60.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                color: Colors.black87,
                iconSize: 36,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.maybePop(context);
                  }
                },
              ),
            ),
          ];
        },
        body: Column(
          children: [
            if (loading) const LoadingBar(),
            Expanded(
              child: WebView(
                gestureRecognizers: gestureRecognizers,

                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onPageFinished: (xx) {
                  setState(() {
                    loading = false;
                  });
                },
                onProgress: (val) {
                  // setState(() {

                  // });
                },
                onPageStarted: (val) {
                  setState(() {
                    loading = true;
                  });
                },
                //'https://flutter.dev',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
