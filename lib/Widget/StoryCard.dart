import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> fetchContent(id) async {
  final response =
      await http.get('https://news-at.zhihu.com/api/4/news/$id');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return jsonDecode(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

renderWebView(context, url, title) {
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new WebviewScaffold(
            url: url,
            appBar: new AppBar(
              title: Text(title),
            )
          )),
    );
}

class StoryCard extends StatelessWidget {
  String imageUrl, title;
  int id;
  StoryCard(this.imageUrl, this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('tapped');
        fetchContent(id)
          .then((data) {
            renderWebView(context, data['share_url'], data['title']);
          });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
        children: <Widget>[
          // info
          new Container(
            height: 124.0,
            padding: EdgeInsets.only(right: 108.0),
            child: Container(
              padding: EdgeInsets.all(6.0),
              child: Center(
                child: Text(title)
              ),
            ),
            decoration: new BoxDecoration(
              color: new Color(0xFFB3E5FC),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
          ),
          // image
          new Container(
            margin: new EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
            alignment: FractionalOffset.centerRight,
            child: new Image(
              image: new NetworkImage(imageUrl),
              height: 92.0,
              width: 92.0,
            ),
          ),
        ],
      )
      ),
    );
  }
}
