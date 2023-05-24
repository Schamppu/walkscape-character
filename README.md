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

- /assets
    - /pfp
        - /back_accessories
            - back_1.png
            - ...
        - /human_a
            - /bodies
                - body.png
            - /eyes
                - eyes_1.png
                - ...
            - /face
                - /face_1
                    - angry.png
                    - laughing.png
                    - normal.png
                    - sad.png
                    - smile.png
                    - smirk.png
                    - surprise.png
                    - very_angry.png
                - /...
            - /face_accessories
                - accessory_1.png
                - ...
            - /hairs
                - hair_1.png
                - hair_1_supp.png (if you want parts of the hairstyle drawn to the background)
                - ...
            - /iris
                - iris.png
            - /noses
                - nose_1.png
                - ...
            - /outfits
                - outfit_1.png
                - outfit_1_var1.png
                - ...
        - /human_b ...

The tool uses pixel palette recoloring to swap the hairstyles. You can change the palette to your liking in `/lib/vars.dart`. If you do that, you must also change the default palette (from which the colors get swapped to other one) in `character_image.dart`, both in the `getDefaultColor()` and `getChangedColor()`.

## About code

The tool was developed hastily, and many parts of the code are not meant to be maintained well. Because of my laziness when making this, some of the classes and components are *way longer* than they should. If you'd like to help refactoring it, pull requests
are very welcome.

## Screenshots

![Screenshot #1](/screenshots/sc1.png?raw=true "Screenshot #1")

![Screenshot #2](/screenshots/sc2.png?raw=true "Screenshot #2")

![Screenshot #3](/screenshots/sc3.png?raw=true "Screenshot #3")