import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:flutter/material.dart';

//extends StatelessWidget
class gameNavigation extends StatelessWidget {
  final BuildContext context;
  final GameWidget<SpaceInvaders> game;
  final void Function(Widget newChild) changeScreen;

  gameNavigation(
      {required this.game,
      required this.context,
      required this.changeScreen,
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
        Center(child: Text('Game Menu', style: TextStyle(fontSize: 30, fontFamily: 'retro'))),
        SizedBox(height: 10),
        NavigationButton(
          label: 'Space Game',
          
          onPressed: () {
            changeScreen(game);
          },
        ),
        SizedBox(height: 10),
        NavigationButton(
          label: 'Tic Tac Toe',
          onPressed: () {},
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
    //required this.onHover,
    required this.label,
  });
  final String label;
  final VoidCallback onPressed;
//  final void Function(bool hasFocus) onHover;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      onPressed: onPressed,
      //   onHoverChanged: (_, state) => onHover.call(state.isHovered),
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
                        //border: Border.all(color: Colors.white, width: 5),
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

                // if (state.isHovered) ...[
                //   Positioned.fill(
                //     child: Image.asset(
                //       'assets/images/GameSpaceScreen.png',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ],

                /// Label
                Center(
                  child: Text(label.toUpperCase(), style: TextStyle(fontFamily: 'retro')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
