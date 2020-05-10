import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();
    
    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this // <-- references the TicketProvider mixin
    );

    catAnimation = Tween(begin: 0.0, end: 100.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        ),
      ); 
  }

  void _onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!')
      ),
      body: GestureDetector(
        child: buildAnimation(),
        onTap: _onTap,
      ) 
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (BuildContext context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value)
        );
      },
      child: Cat()
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown
    );
  }
}