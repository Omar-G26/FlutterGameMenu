import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gaminghub/Pages/GameHomePage.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FocusableActionDetector(
            child: SettingsButton(
              label: 'Change Background',
              onPressed: () =>
                  // print('testy')
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BackgroundPage(),
                ),
              ),
            ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds),
          ),
          const SizedBox(height: 16),
          FocusableActionDetector(
              child: SettingsButton(
            label: 'Volume',
            onPressed: () => print('hi'),

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Other(),
            //   ),
            // ),
          ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}

class BackgroundPage extends StatefulWidget {
  const BackgroundPage({Key? key}) : super(key: key);
  @override
  Background createState() => Background();
}

class Background extends State<BackgroundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FocusableActionDetector(
            child: SettingsButton(
              label: 'BackGround 1',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BackgroundPage(),
                ),
              ),
            ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds),
          ),
          const SizedBox(height: 16),
          FocusableActionDetector(
              child: SettingsButton(
            label: 'Background 2',
            onPressed: () => print('hi'),
          ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
          const SizedBox(height: 16),
          FocusableActionDetector(
              child: SettingsButton(
            label: 'Background 3',
            onPressed: () => print('hi'),
          ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
          const SizedBox(height: 16),
          FocusableActionDetector(
              child: SettingsButton(
            label: 'No Background',
            onPressed: () => print('hi'),
          ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
        ]),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
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
                      //border: Border.all(color: Colors.white, width: 5),
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
