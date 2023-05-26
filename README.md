# WalkScape character customisation tool

WalkScape character customisation tool was developed to let the audience try out the character customisation functionality in WalkScape. This lets us, the developer team, gather feedback and suggestions on how to improve the customisation while also making it
easy to catch any bugs.

The tool is fully developed with Flutter. It's made to be responsive and should work fine on both mobile and desktop.

**You can try the tool here:** [pfp.walkscape.app](https://pfp.walkscape.app).

If you are interested in the actual game project this is related to, check out [walkscape.app](https://walkscape.app)

## How to get it work

You need to setup Flutter for your PC. You can follow [these official docs](https://docs.flutter.dev/get-started/install) to get started.

After you've setup the project properly on your PC, you can start the project with `flutter run -d chrome`.

**Important:** The project needs an `/assets` folder to work properly. This **is not included** with the project, as those are game assets that are used in the real game and not something we want to share openly. You can make your own assets and use those
with the tool. Keeping the folder structure similar is essential to make the tool work - otherwise you'll need to change the paths in `pfp_manager.dart`. The folder structure is the following:

We have instead provided you with a `assets_placeholder` folder. It has some samples inside and shows the generic folder structure. If you rename that folder to `/assets`, the project should start up just fine.

The tool uses pixel palette recoloring to swap the hairstyles. You can change the palette to your liking in `/lib/vars.dart`. If you do that, you must also change the default palette (from which the colors get swapped to other one) in `functions.dart` file's `initProviders()` function.

## About code

The tool was refactored, and now uses Riverpod's state management providers. If you have improvements or bug fixes in mind, I'm more than happy to receive pull requests.

## File naming conventions

`ex_` means that the asset is exclusive, and needs the developer mode activated to be unlocked.

`_bck` means that the asset is "supplementary" and drawn to the background. This is used in hairstyles and headware to make some parts of the asset be drawn behind the character.

`_var` means that the asset is a variant. This means that it's basically the same asset, but with some minor changes (like color changes) to it.

## Copyrights and usage

You can use the tool for your own projects, but please don't use the provided art assets in other way than a starting point. If you are familiar in pixel art, you can also use the tool to try out your own character customization assets for WalkScape and suggest them for us to use in the game! It would be awesome to see your creations made with the tool.


## Screenshots (after refactoring)

![Screenshot #1](/screenshots/sc4.png?raw=true "Screenshot #1")

![Screenshot #2](/screenshots/sc5.png?raw=true "Screenshot #2")

![Screenshot #3](/screenshots/sc6.png?raw=true "Screenshot #3")

![Screenshot #3](/screenshots/sc7.png?raw=true "Screenshot #4")

## Screenshots (before refactoring)

![Screenshot #1](/screenshots/sc1.png?raw=true "Screenshot #1")

![Screenshot #2](/screenshots/sc2.png?raw=true "Screenshot #2")

![Screenshot #3](/screenshots/sc3.png?raw=true "Screenshot #3")