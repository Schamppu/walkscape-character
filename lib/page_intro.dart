import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/character_creator.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PageIntro extends StatelessWidget {
  const PageIntro({super.key});

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: 1000.ms,
      pageBuilder: (context, animation, secondaryAnimation) => const PageCharacterCreator(
        title: 'WalkScape Character Customisation',
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _goToWebsite() {
    final anchor = html.AnchorElement(href: 'https://walkscape.app')..target = 'blank';
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleShadow(
                  opacity: Theme.of(context).brightness == Brightness.dark ? 0.5 : 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      'assets/logo_cutcorners.svg',
                      semanticsLabel: 'WalkScape logo',
                      width: ResponsiveBreakpoints.of(context).isDesktop ? 128 : 64,
                      height: ResponsiveBreakpoints.of(context).isDesktop ? 128 : 64,
                    ),
                  ).animate().scale(delay: 800.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                ),
                Text(
                  'WalkScape',
                  style: TextStyle(
                      fontSize: ResponsiveBreakpoints.of(context).isDesktop ? 50 : 30,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.amber[200] : Colors.amber[900]),
                )
                    .animate()
                    .fade(delay: 400.ms, duration: 500.ms, curve: Curves.easeInOutCirc)
                    .slideY(delay: 500.ms, duration: 500.ms, begin: -2, end: 0.0, curve: Curves.easeInOutCirc),
                Text(
                  'Character Customization tool',
                  style: TextStyle(
                      fontSize: ResponsiveBreakpoints.of(context).isDesktop ? 20 : 18, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700),
                ).animate().fade(delay: 1500.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to the WalkScape character customisation tool!\n\nThis tool can be used to try out the character customisation that is also found directly within the game.\nYou can create a character and download it as a .png to use where ever you like.\n\nSuggestions for more styles and options are very welcome. Reporting any possible graphical issues is also important so we can make sure all of the sprites work perfectly in the game.\n\nYou can contact us from any of the socials found from the website, or by sending mail to contact@walkscape.app.',
                    style: TextStyle(fontSize: ResponsiveBreakpoints.of(context).isDesktop ? 18 : 12, color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ).animate().fade(delay: 1500.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FilledButton(
                          onPressed: () {
                            Navigator.push(context, _createRoute());
                          },
                          child: Text('Begin'))
                      .animate()
                      .scale(delay: 2000.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FilledButton(onPressed: _goToWebsite, child: Text('Our website')).animate().scale(delay: 2000.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
