library markdown_from_url;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MarkdownFromUrlPresenter extends StatelessWidget {
  final String url;

  MarkdownFromUrlPresenter({@required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: http.get(url),
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) =>
          response.hasData && response.data.statusCode == 200
              ? RawMarkdownPresenter(
                  rawMarkdown: response.data.body,
                )
              : CircularProgressIndicator(),
    );
  }
}

class RawMarkdownPresenter extends StatelessWidget {
  final String rawMarkdown;

  RawMarkdownPresenter({@required this.rawMarkdown});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: rawMarkdown,
      onTapLink: (link) => launch(link),
    );
  }
}

class MarkdownFromUrl {
  static showFullScreen(final BuildContext context, final String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: MarkdownFromUrlPresenter(
              url: url,
            ),
          ),
        ),
      ),
    );
  }
}
