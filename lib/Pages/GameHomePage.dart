import 'package:flutter/material.dart';
import 'package:gaminghub/main.dart';
import 'package:gaminghub/Pages/GameSelectionPage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:gaminghub/Pages/SettingsPage.dart';
class GameHomePage extends StatelessWidget {
  const GameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Home'),
      ),
      body:
      Stack(children: [
        // Positioned.fill(
        //       child:  Image(image: AssetImage('assets/backgroundImages/maxresdefault.jpg'),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
       Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameSelectButton(
              label: 'Play',
              onPressed: () =>
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionPage(),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add space between buttons
            GameSelectButton(
              label: 'Settings',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add space between buttons
            GameSelectButton(
              label: 'Scores',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScoresPage(),
                ),
              ),
            ),
          ],
        ),
      )
      ]),
    );
  }
}

class GameMenuButton extends StatelessWidget {
  const GameMenuButton({
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
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 250,
            height: 60,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: (!(state.isHovered || state.isFocused)) ? 1 : 0,
                  duration: .3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                    ),
                  ),
                ),

                if (state.isHovered || state.isFocused) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
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
