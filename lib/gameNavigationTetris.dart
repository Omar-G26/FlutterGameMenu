import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/SpaceGameMenu.dart';
import 'package:gaminghub/TicTacToe/TicTacToe.dart';

//extends StatelessWidget
class gameNavigationTetris extends StatelessWidget {
  final BuildContext context;
  final Timer timer;

  gameNavigationTetris(
      {
      required this.context,
      required this.timer,

      super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Stack(children: [
        //  SizedBox(height: 30  , width: 30, child:
        Drawer(
            child: Center(
                child: ListView(
      children: [
        SizedBox(height: 30),
        Center(
            child: Text('Game Menu',
                style: TextStyle(fontSize: 30, fontFamily: 'retro'))),
        SizedBox(height: 10),
        NavigationButton(
          label: 'Space Game',
          onPressed: () {
            timer.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SpaceInvadersPage(),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        NavigationButton(
          label: 'Tic Tac Toe',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TicTacToeGame(),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        NavigationButton(
          label: 'Tetris',
          onPressed: () {},
        ),
      ],
    )));
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    required this.onPressed,
    required this.label,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      onPressed: onPressed,
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 120,
            height: 60,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: (!(state.isHovered || state.isFocused)) ? 1 : 0,
                  duration: .3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF00D1FF).withOpacity(.1),
                        borderRadius: BorderRadius.circular(20)
                        ),
                  ),
                ),

                if (state.isHovered || state.isFocused) ...[
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF00D1FF).withOpacity(.1),
                        border: Border.all(color: Colors.white, width: 5),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],

                Center(
                  child: Text(label.toUpperCase(),
                      style: TextStyle(fontFamily: 'retro')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NavigationTetris extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  NavigationTetris({
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }
}
