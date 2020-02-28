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
              ? Markdown(
                  data: response.data.body,
                  onTapLink: (link) => launch(link),
                )
              : CircularProgressIndicator(),
    );
  }
}
