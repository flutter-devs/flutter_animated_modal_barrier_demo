
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedDemoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedDemoScreenState();
}

class _AnimatedDemoScreenState extends State<AnimatedDemoScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  Widget _animatedModalBarrier;

  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    ColorTween  _colorTween = ColorTween(
      begin: Color.fromARGB(200, 155, 120, 155),
      end: Color.fromARGB(100, 127, 127, 127),
    );

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    );
    _colorAnimation = _colorTween.animate(_animationController);

    _animatedModalBarrier = AnimatedModalBarrier(
      color: _colorAnimation,
      dismissible: true,
    );

    super.initState();
  }

  List<Widget> buildList(BuildContext context) {
    List<Widget> widgets = <Widget>[
      RaisedButton(
        padding: EdgeInsets.only(left: 40,right: 40),
        color: Colors.teal[200],
        child: Text('Press'),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });

          _animationController.reset();
          _animationController.forward();

          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Button is press'),
              backgroundColor: Colors.black,),
          );

          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              _isLoading = false;
            });
          });
        },
      ),
    ];

    if (_isLoading) {
      widgets.add(_animatedModalBarrier);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('Flutter AnimatedModalBarrier Demo'),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 250.0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: buildList(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}