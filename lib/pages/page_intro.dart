import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/pages/page_character_creator.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PageIntro extends ConsumerWidget {
  PageIntro({super.key});
  final TextEditingController _controller = TextEditingController();

  /// Creates a route to the main application
  Route _createRoute(BuildContext context, WidgetRef ref) {
    /// Initializes the providers
    if (!PfpManager().initialized) {
      initProviders(ref);
      PfpManager().initialized = true;
    }
    return PageRouteBuilder(
      transitionDuration: 1000.ms,
      pageBuilder: (context, animation, secondaryAnimation) => PageCharacterCreator(
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

  /// Goes to the website
  void _goToWebsite(String url) {
    final anchor = html.AnchorElement(href: url)..target = 'blank';
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  /// Loads the password from a text file
  Future<String?> _loadPassword(BuildContext context) async {
    try {
      return await rootBundle.loadString(kDebugMode ? 'dev.txt' : 'assets/dev.txt');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SimpleShadow(
          child: Text(
            'Failed to load secret password file.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red[600],
      ));
      return null;
    }
  }

  /// Checks if the password is correct to unlock developer mode
  Future<void> _checkPassword(BuildContext context) async {
    print('asd');
    final password = await _loadPassword(context);
    if (password != null) {
      if (_controller.text == password) {
        if (!PfpManager().initialized) {
          // Password is correct
          PfpManager().developer = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: SimpleShadow(
              child: Text(
                'Developer mode activated!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.green[600],
          ));
        } else {
          // App is already initialized and needs to be restarted
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: SimpleShadow(
              child: Text(
                'App is already initialized. Refresh the app and activate developer mode immediately before pressing "begin".',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.red[600],
          ));
        }
        Navigator.pop(context);
      } else {
        // Password is wrong
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SimpleShadow(
            child: Text(
              'Password is incorrect',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.red[600],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SizedBox(
                                      width: getCardWidth(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Enter password for developer mode:'),
                                          TextField(
                                            controller: _controller,
                                            onSubmitted: (string) {
                                              _checkPassword(context);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: FilledButton(
                                                onPressed: () {
                                                  // Try if the developer password is correct.
                                                  _checkPassword(context);
                                                },
                                                child: const Text('Submit')),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          kDebugMode ? 'logo_cutcorners.svg' : 'assets/logo_cutcorners.svg',
                          semanticsLabel: 'WalkScape logo',
                          width: ResponsiveBreakpoints.of(context).isDesktop ? 128 : 64,
                          height: ResponsiveBreakpoints.of(context).isDesktop ? 128 : 64,
                        )
                            .animate(
                              onComplete: (controller) => Future.delayed(1500.ms, () {
                                controller.reset();
                                controller.forward();
                              }),
                            )
                            .shimmer(duration: 2000.ms, curve: Curves.easeInOutCirc)),
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
                    'This tool can be used to try out the character customisation that is also found directly within the game. You can create a character and download it as a .png to use where ever you like.\n\nSuggestions for more styles and options are very welcome. Reporting any possible graphical issues is also important so we can make sure all of the sprites work perfectly in the game.\n\nYou can contact us from any of the socials found from the website, or by sending mail to contact@walkscape.app.',
                    style: TextStyle(fontSize: ResponsiveBreakpoints.of(context).isDesktop ? 18 : 12, color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ).animate().fade(delay: 1500.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: FilledButton(
                              onPressed: () {
                                Navigator.push(context, _createRoute(context, ref));
                              },
                              style: ElevatedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                child: Text('Begin'),
                              )).animate().scale(delay: 2000.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: OutlinedButton(
                              onPressed: () {
                                _goToWebsite('https://walkscape.app');
                              },
                              style: OutlinedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                child: Text('Our website'),
                              )).animate().scale(delay: 2300.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: OutlinedButton(
                              onPressed: () {
                                _goToWebsite('https://www.patreon.com/WalkScape');
                              },
                              style: OutlinedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_outline,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Patreon'),
                                  ],
                                ),
                              )).animate().scale(delay: 2600.ms, duration: 500.ms, curve: Curves.easeInOutCirc),
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
