import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class StoryCard extends StatelessWidget {
  String imageUrl, title, url;
  StoryCard(this.imageUrl, this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('tapped');
        new FlutterWebviewPlugin().launch(url);
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
