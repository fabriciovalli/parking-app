import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(
          Icons.dehaze,
          size: 25.0,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        });
  }
}

class FloatButton extends StatelessWidget {
  final dynamic icon;
  final Function navigate;
  FloatButton({this.icon, this.navigate});
  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
        onPressed: this.navigate,
        backgroundColor: const Color.fromRGBO(255, 51, 102, 1.0),
        child: new Icon(
          icon,
          size: 25.0,
          color: Colors.white,
        ));
  }
}

class TopFloatButton extends StatelessWidget {
  final dynamic icon;
  final double top;
  final Function navigate;
  TopFloatButton({this.icon, this.navigate, this.top});
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topRight,
      padding: new EdgeInsets.only(top: top),
      child: new FloatingActionButton(
          onPressed: this.navigate,
          backgroundColor: const Color.fromRGBO(255, 51, 102, 1.0),
          child: new Icon(
            icon,
            size: 25.0,
            color: Colors.white,
          )),
    );
  }
}

class RoundButton extends StatelessWidget {
  final dynamic color;
  final String text;
  final double height;
  final double width;
  final Function onPressed;
  final double borderRadius;
  RoundButton({this.color, this.text, this.height, this.width, this.onPressed, this.borderRadius: 10.0});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius)),
      child: new Material(
        child: new InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: this.onPressed,
          child: new Center(
            child: new Text(
              text,
              style: new TextStyle(
                color: Theme.of(context).primaryTextTheme.title.color,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
