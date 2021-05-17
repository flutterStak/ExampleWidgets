import 'package:flutter/material.dart';

import 'Page_1.dart';
import 'Page_2.dart';
import 'Page_3.dart';

void main() {
  runApp(
      MaterialApp(home:DemoApp())
  );
}
class DemoApp extends StatefulWidget {
  @override
  State createState() {
    return _DemoState();
  }
}

AnimationController controller;
class _DemoState extends State with TickerProviderStateMixin {
  int i=0;
  Widget _child;
  List<Widget> PageList=[Page1(),Page2(),Page3()];
  @override
  void initState() {
    controller= AnimationController(vsync:this);
    controller.duration=Duration(milliseconds: 100);
    _child = PageList[0];
    super.initState();
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(leading: InkWell(
            onTap: (){
              FocusScopeNode currentFocus=FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

              controller.isDismissed?controller.forward():controller.reverse();
            },
            child: Icon(Icons.menu,color: Colors.black,)),
          backgroundColor: Colors.white,elevation: 0,
        ),
        body: AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            double scale= 1-(controller.value*0.3);
            double slidex= MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*scale;
            double slidey=(MediaQuery.of(context).size.height
                -MediaQuery.of(context).size.height*scale)*controller.value/2;
            return  Stack(
                children:[
                  //FluidNavBar(onChange: _handleNavigationChange,),

                  Container(
                    width: 60,
                    child: NavigationRail(
                        destinations: [
                          NavigationRailDestination(icon: Image.asset('Assets/Images/5469.jpg',fit:BoxFit.contain,),label: Text('Group 1'),selectedIcon: Text('G1')),
                          NavigationRailDestination(icon: Image.asset('Assets/Images/2650152.jpg',fit:BoxFit.contain),label: Text('Group 2'),selectedIcon: Text('G2')),
                          NavigationRailDestination(icon: Image.asset('Assets/Images/4293766.jpg',fit:BoxFit.contain),label: Text('Group 3'),selectedIcon: Text('G3')),
                        ],
                        selectedIndex: i,onDestinationSelected: _handleNavigationChange,minWidth: 120,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.reverse();
                    },
                    child: Transform(
                      transform: Matrix4.identity()..translate(slidex,slidey)..scale(scale),
                      child: _child,
                    ),
                  ),

                ]);
          }, animation: controller,
        ),
        //  bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
      ),
    );
  }


  void _handleNavigationChange(int index) {

    setState(() {
      switch (index) {
        case 0:
          _child = PageList[0];
          i=0;
          break;
        case 1:
          _child = PageList[1];
          i=1;
          break;
        case 2:
          _child = PageList[2];
          i=2;
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

}
