import 'package:flutter/material.dart';

const layerFacepaint = -1;
const layerBackAccessory = 0;
const layerHairSupp = 1;
const layerHeadwearSupp = 1;
const layerBody = 2;
const layerOutfit = 3;
const layerFace = 4;
const layerNose = 6;
const layerFaceAccessory = 7;
const layerEyes = 8;
const layerHair = 9;
const layerHeadwear = 10;

const rootFolder = 'assets/pfp/';

const colorOptionsSkin = {
  'very light': [
    Color.fromARGB(255, 191, 111, 74),
    Color.fromARGB(255, 230, 156, 105),
    Color.fromARGB(255, 246, 202, 159),
    Color.fromARGB(255, 249, 230, 207),
  ],
  'light': [
    Color.fromARGB(255, 138, 72, 54),
    Color.fromARGB(255, 191, 111, 74),
    Color.fromARGB(255, 230, 156, 105),
    Color.fromARGB(255, 246, 202, 159),
  ],
  'medium': [
    Color.fromARGB(255, 93, 44, 40),
    Color.fromARGB(255, 138, 72, 54),
    Color.fromARGB(255, 191, 111, 74),
    Color.fromARGB(255, 230, 156, 105),
  ],
  'dark': [
    Color.fromARGB(255, 57, 31, 33),
    Color.fromARGB(255, 93, 44, 40),
    Color.fromARGB(255, 138, 72, 54),
    Color.fromARGB(255, 191, 111, 74),
  ],
  'very dark': [
    Color.fromARGB(255, 28, 18, 28),
    Color.fromARGB(255, 57, 31, 33),
    Color.fromARGB(255, 93, 44, 40),
    Color.fromARGB(255, 138, 72, 54),
  ],
};

const colorOptionsBackground = {
  'red': [
    Color.fromARGB(255, 255, 82, 119),
  ],
  'blue': [
    Color.fromARGB(255, 79, 164, 184),
  ],
  'light green': [
    Color.fromARGB(255, 200, 212, 93),
  ],
  'orange': [
    Color.fromARGB(255, 255, 137, 51),
  ],
  'yellow': [
    Color.fromARGB(255, 240, 181, 65),
  ],
  'cyan': [
    Color.fromARGB(255, 32, 214, 199),
  ],
  'brown': [
    Color.fromARGB(255, 160, 134, 98),
  ],
  'grayish blue': [
    Color.fromARGB(255, 163, 167, 194),
  ],
  'almost white': [
    Color.fromARGB(255, 223, 224, 232),
  ],
};

const colorOptionsEyes = {
  'black': [
    Color.fromARGB(255, 19, 19, 19),
    Color.fromARGB(255, 39, 39, 39),
  ],
  'darker brown': [
    Color.fromARGB(255, 61, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
  ],
  'dark brown': [
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 125, 56, 51),
  ],
  'brown': [
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
  ],
  'dark red': [
    Color.fromARGB(255, 79, 29, 76),
    Color.fromARGB(255, 120, 29, 79),
  ],
  'red': [
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
  ],
  'dark blue': [
    Color.fromARGB(255, 43, 43, 69),
    Color.fromARGB(255, 58, 63, 94),
  ],
  'blue': [
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
  ],
  'light blue': [
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
  ],
  'dark green': [
    Color.fromARGB(255, 40, 53, 64),
    Color.fromARGB(255, 47, 87, 83),
  ],
  'green': [
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
  ],
  'light green': [
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
  ],
  'dark magenta': [
    Color.fromARGB(255, 41, 29, 43),
    Color.fromARGB(255, 64, 41, 54),
  ],
  'magenta': [
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
  ],
  'light magenta': [
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
  ],
  'dark brownish': [
    Color.fromARGB(255, 66, 57, 52),
    Color.fromARGB(255, 90, 78, 68),
  ],
  'brownish': [
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
  ],
  'light brownish': [
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
  ],
  'dark': [
    Color.fromARGB(255, 27, 27, 27),
    Color.fromARGB(255, 39, 39, 39),
  ],
  'gray': [
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
  ],
  'light gray': [
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
  ],
  'dark ginger': [
    Color.fromARGB(255, 87, 28, 39),
    Color.fromARGB(255, 142, 37, 29),
  ],
  'ginger': [
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
  ],
  'light ginger': [
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
  ],
  'dark purple': [
    Color.fromARGB(255, 75, 29, 82),
    Color.fromARGB(255, 105, 36, 100),
  ],
  'purple': [
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
  ],
  'light purple': [
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
  ],
  'blueish darkest': [
    Color.fromARGB(255, 14, 7, 27),
    Color.fromARGB(255, 26, 25, 50),
  ],
  'blueish darker': [
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
  ],
  'blueish dark': [
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
  ],
  'blueish': [
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
  ],
  'light blueish': [
    Color.fromARGB(255, 101, 115, 146),
    Color.fromARGB(255, 146, 161, 185),
  ],
};

const colorOptionsHair = {
  'darkest brown': [
    Color.fromARGB(255, 59, 32, 39),
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
  ],
  'dark brown': [
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
    Color.fromARGB(255, 207, 117, 43),
  ],
  'brown': [
    Color.fromARGB(255, 171, 81, 48),
    Color.fromARGB(255, 207, 117, 43),
    Color.fromARGB(255, 240, 181, 65),
  ],
  'light brown': [
    Color.fromARGB(255, 207, 117, 43),
    Color.fromARGB(255, 240, 181, 65),
    Color.fromARGB(255, 255, 238, 131),
  ],
  'darkest red': [
    Color.fromARGB(255, 79, 29, 76),
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
  ],
  'dark red': [
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
    Color.fromARGB(255, 230, 69, 57),
  ],
  'red': [
    Color.fromARGB(255, 173, 47, 69),
    Color.fromARGB(255, 230, 69, 57),
    Color.fromARGB(255, 255, 137, 51),
  ],
  'light red': [
    Color.fromARGB(255, 230, 69, 57),
    Color.fromARGB(255, 255, 137, 51),
    Color.fromARGB(255, 255, 194, 161),
  ],
  'darkest blue': [
    Color.fromARGB(255, 43, 43, 69),
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
  ],
  'darker blue': [
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
  ],
  'blue': [
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
    Color.fromARGB(255, 146, 232, 192),
  ],
  'light blue': [
    Color.fromARGB(255, 79, 164, 184),
    Color.fromARGB(255, 146, 232, 192),
    Color.fromARGB(255, 245, 255, 232),
  ],
  'darkest green': [
    Color.fromARGB(255, 40, 53, 64),
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
  ],
  'dark green': [
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
  ],
  'green': [
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
    Color.fromARGB(255, 200, 212, 93),
  ],
  'light green': [
    Color.fromARGB(255, 99, 171, 63),
    Color.fromARGB(255, 200, 212, 93),
    Color.fromARGB(255, 255, 238, 131),
  ],
  'darkest magenta': [
    Color.fromARGB(255, 41, 29, 43),
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
  ],
  'dark magenta': [
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
  ],
  'magenta': [
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
    Color.fromARGB(255, 189, 106, 98),
  ],
  'light magenta': [
    Color.fromARGB(255, 143, 77, 87),
    Color.fromARGB(255, 189, 106, 98),
    Color.fromARGB(255, 255, 174, 112),
  ],
  'darkest brownish': [
    Color.fromARGB(255, 66, 57, 52),
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
  ],
  'dark brownish': [
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
  ],
  'brownish': [
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
    Color.fromARGB(255, 199, 176, 139),
  ],
  'light brownish': [
    Color.fromARGB(255, 160, 134, 98),
    Color.fromARGB(255, 199, 176, 139),
    Color.fromARGB(255, 228, 210, 170),
  ],
  'black': [
    Color.fromARGB(255, 27, 27, 27),
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
  ],
  'darker': [
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
  ],
  'dark': [
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 133, 133, 133),
  ],
  'gray': [
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 133, 133, 133),
    Color.fromARGB(255, 180, 180, 180),
  ],
  'light gray': [
    Color.fromARGB(255, 133, 133, 133),
    Color.fromARGB(255, 180, 180, 180),
    Color.fromARGB(255, 218, 224, 234),
  ],
  'dark ginger': [
    Color.fromARGB(255, 87, 28, 39),
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
  ],
  'ginger': [
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
  ],
  'light ginger': [
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
    Color.fromARGB(255, 237, 171, 80),
  ],
  'dark purple': [
    Color.fromARGB(255, 75, 29, 82),
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
  ],
  'purple': [
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
  ],
  'light purple': [
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
    Color.fromARGB(255, 255, 82, 119),
  ],
  'blueish darkest': [
    Color.fromARGB(255, 14, 7, 27),
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
  ],
  'blueish darker': [
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
  ],
  'blueish dark': [
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
  ],
  'blueish': [
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
    Color.fromARGB(255, 146, 161, 185),
  ],
  'light blueish': [
    Color.fromARGB(255, 101, 115, 146),
    Color.fromARGB(255, 146, 161, 185),
    Color.fromARGB(255, 199, 207, 221),
  ],
};

const colorOptionsFacialHair = {
  'darker brown': [
    Color.fromARGB(255, 61, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
  ],
  'dark brown': [
    Color.fromARGB(255, 59, 32, 39),
    Color.fromARGB(255, 125, 56, 51),
  ],
  'brown': [
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
  ],
  'dark red': [
    Color.fromARGB(255, 79, 29, 76),
    Color.fromARGB(255, 120, 29, 79),
  ],
  'red': [
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
  ],
  'dark blue': [
    Color.fromARGB(255, 43, 43, 69),
    Color.fromARGB(255, 58, 63, 94),
  ],
  'blue': [
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
  ],
  'light blue': [
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
  ],
  'dark green': [
    Color.fromARGB(255, 40, 53, 64),
    Color.fromARGB(255, 47, 87, 83),
  ],
  'green': [
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
  ],
  'light green': [
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
  ],
  'dark magenta': [
    Color.fromARGB(255, 41, 29, 43),
    Color.fromARGB(255, 64, 41, 54),
  ],
  'magenta': [
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
  ],
  'light magenta': [
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
  ],
  'dark brownish': [
    Color.fromARGB(255, 66, 57, 52),
    Color.fromARGB(255, 90, 78, 68),
  ],
  'brownish': [
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
  ],
  'light brownish': [
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
  ],
  'dark': [
    Color.fromARGB(255, 27, 27, 27),
    Color.fromARGB(255, 39, 39, 39),
  ],
  'gray': [
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
  ],
  'light gray': [
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
  ],
  'dark ginger': [
    Color.fromARGB(255, 87, 28, 39),
    Color.fromARGB(255, 142, 37, 29),
  ],
  'ginger': [
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
  ],
  'light ginger': [
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
  ],
  'dark purple': [
    Color.fromARGB(255, 75, 29, 82),
    Color.fromARGB(255, 105, 36, 100),
  ],
  'purple': [
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
  ],
  'light purple': [
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
  ],
  'blueish darkest': [
    Color.fromARGB(255, 14, 7, 27),
    Color.fromARGB(255, 26, 25, 50),
  ],
  'blueish darker': [
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
  ],
  'blueish dark': [
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
  ],
  'blueish': [
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
  ],
  'light blueish': [
    Color.fromARGB(255, 101, 115, 146),
    Color.fromARGB(255, 146, 161, 185),
  ],
};

const colorOptionsEyebrows = {
  'black': [
    Color.fromARGB(255, 27, 27, 27),
  ],
  'dark': [
    Color.fromARGB(255, 39, 39, 39),
  ],
  'gray': [
    Color.fromARGB(255, 93, 93, 93),
  ],
  'light gray': [
    Color.fromARGB(255, 133, 133, 133),
  ],
  'darkest brown': [
    Color.fromARGB(255, 59, 32, 39),
  ],
  'dark brown': [
    Color.fromARGB(255, 125, 56, 51),
  ],
  'brown': [
    Color.fromARGB(255, 171, 81, 48),
  ],
  'light brown': [
    Color.fromARGB(255, 207, 117, 43),
  ],
  'darkest red': [
    Color.fromARGB(255, 79, 29, 76),
  ],
  'dark red': [
    Color.fromARGB(255, 120, 29, 79),
  ],
  'red': [
    Color.fromARGB(255, 173, 47, 69),
  ],
  'light red': [
    Color.fromARGB(255, 230, 69, 57),
  ],
  'darker blue': [
    Color.fromARGB(255, 58, 63, 94),
  ],
  'blue': [
    Color.fromARGB(255, 76, 104, 133),
  ],
  'light blue': [
    Color.fromARGB(255, 79, 164, 184),
  ],
  'darkest green': [
    Color.fromARGB(255, 40, 53, 64),
  ],
  'dark green': [
    Color.fromARGB(255, 47, 87, 83),
  ],
  'green': [
    Color.fromARGB(255, 56, 125, 79),
  ],
  'light green': [
    Color.fromARGB(255, 99, 171, 63),
  ],
  'darkest magenta': [
    Color.fromARGB(255, 41, 29, 43),
  ],
  'dark magenta': [
    Color.fromARGB(255, 64, 41, 54),
  ],
  'magenta': [
    Color.fromARGB(255, 82, 51, 63),
  ],
  'light magenta': [
    Color.fromARGB(255, 143, 77, 87),
  ],
  'darkest brownish': [
    Color.fromARGB(255, 66, 57, 52),
  ],
  'dark brownish': [
    Color.fromARGB(255, 90, 78, 68),
  ],
  'brownish': [
    Color.fromARGB(255, 121, 103, 85),
  ],
  'light brownish': [
    Color.fromARGB(255, 160, 134, 98),
  ],
  'dark ginger': [
    Color.fromARGB(255, 87, 28, 39),
  ],
  'ginger': [
    Color.fromARGB(255, 142, 37, 29),
  ],
  'light ginger': [
    Color.fromARGB(255, 198, 69, 36),
  ],
  'dark purple': [
    Color.fromARGB(255, 75, 29, 82),
  ],
  'purple': [
    Color.fromARGB(255, 105, 36, 100),
  ],
  'light purple': [
    Color.fromARGB(255, 156, 42, 112),
  ],
  'blueish darkest': [
    Color.fromARGB(255, 14, 7, 27),
  ],
  'blueish darker': [
    Color.fromARGB(255, 26, 25, 50),
  ],
  'blueish dark': [
    Color.fromARGB(255, 42, 47, 78),
  ],
  'blueish': [
    Color.fromARGB(255, 66, 76, 110),
  ],
  'light blueish': [
    Color.fromARGB(255, 101, 115, 146),
  ],
};

const colorOptionsFacepaint = {
  'dark brown': [
    Color.fromARGB(255, 59, 32, 39),
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
    Color.fromARGB(255, 207, 117, 43),
  ],
  'brown': [
    Color.fromARGB(255, 125, 56, 51),
    Color.fromARGB(255, 171, 81, 48),
    Color.fromARGB(255, 207, 117, 43),
    Color.fromARGB(255, 240, 181, 65),
  ],
  'light brown': [
    Color.fromARGB(255, 171, 81, 48),
    Color.fromARGB(255, 207, 117, 43),
    Color.fromARGB(255, 240, 181, 65),
    Color.fromARGB(255, 255, 238, 131),
  ],
  'dark red': [
    Color.fromARGB(255, 79, 29, 76),
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
    Color.fromARGB(255, 230, 69, 57),
  ],
  'red': [
    Color.fromARGB(255, 120, 29, 79),
    Color.fromARGB(255, 173, 47, 69),
    Color.fromARGB(255, 230, 69, 57),
    Color.fromARGB(255, 255, 137, 51),
  ],
  'light red': [
    Color.fromARGB(255, 173, 47, 69),
    Color.fromARGB(255, 230, 69, 57),
    Color.fromARGB(255, 255, 137, 51),
    Color.fromARGB(255, 255, 194, 161),
  ],
  'darker blue': [
    Color.fromARGB(255, 43, 43, 69),
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
  ],
  'blue': [
    Color.fromARGB(255, 58, 63, 94),
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
    Color.fromARGB(255, 146, 232, 192),
  ],
  'light blue': [
    Color.fromARGB(255, 76, 104, 133),
    Color.fromARGB(255, 79, 164, 184),
    Color.fromARGB(255, 146, 232, 192),
    Color.fromARGB(255, 245, 255, 232),
  ],
  'dark green': [
    Color.fromARGB(255, 40, 53, 64),
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
  ],
  'green': [
    Color.fromARGB(255, 47, 87, 83),
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
    Color.fromARGB(255, 200, 212, 93),
  ],
  'light green': [
    Color.fromARGB(255, 56, 125, 79),
    Color.fromARGB(255, 99, 171, 63),
    Color.fromARGB(255, 200, 212, 93),
    Color.fromARGB(255, 255, 238, 131),
  ],
  'dark magenta': [
    Color.fromARGB(255, 41, 29, 43),
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
  ],
  'magenta': [
    Color.fromARGB(255, 64, 41, 54),
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
    Color.fromARGB(255, 189, 106, 98),
  ],
  'light magenta': [
    Color.fromARGB(255, 82, 51, 63),
    Color.fromARGB(255, 143, 77, 87),
    Color.fromARGB(255, 189, 106, 98),
    Color.fromARGB(255, 255, 174, 112),
  ],
  'dark brownish': [
    Color.fromARGB(255, 66, 57, 52),
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
  ],
  'brownish': [
    Color.fromARGB(255, 90, 78, 68),
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
    Color.fromARGB(255, 199, 176, 139),
  ],
  'light brownish': [
    Color.fromARGB(255, 121, 103, 85),
    Color.fromARGB(255, 160, 134, 98),
    Color.fromARGB(255, 199, 176, 139),
    Color.fromARGB(255, 228, 210, 170),
  ],
  'dark grey': [
    Color.fromARGB(255, 27, 27, 27),
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
  ],
  'grey': [
    Color.fromARGB(255, 39, 39, 39),
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 133, 133, 133),
  ],
  'light grey': [
    Color.fromARGB(255, 61, 61, 61),
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 180, 180, 180),
  ],
  'white': [
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 93, 93, 93),
    Color.fromARGB(255, 180, 180, 180),
    Color.fromARGB(255, 218, 224, 234),
  ],
  'ginger': [
    Color.fromARGB(255, 87, 28, 39),
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
  ],
  'light ginger': [
    Color.fromARGB(255, 142, 37, 29),
    Color.fromARGB(255, 198, 69, 36),
    Color.fromARGB(255, 224, 116, 56),
    Color.fromARGB(255, 237, 171, 80),
  ],
  'purple': [
    Color.fromARGB(255, 75, 29, 82),
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
  ],
  'light purple': [
    Color.fromARGB(255, 105, 36, 100),
    Color.fromARGB(255, 156, 42, 112),
    Color.fromARGB(255, 204, 47, 123),
    Color.fromARGB(255, 255, 82, 119),
  ],
  'dark blueish': [
    Color.fromARGB(255, 14, 7, 27),
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
  ],
  'blueish': [
    Color.fromARGB(255, 26, 25, 50),
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
  ],
  'light blueish': [
    Color.fromARGB(255, 42, 47, 78),
    Color.fromARGB(255, 66, 76, 110),
    Color.fromARGB(255, 101, 115, 146),
    Color.fromARGB(255, 146, 161, 185),
  ],
};

/* Old ones
const colorOptionsFacepaint = {
  'brown': [
    Color.fromARGB(255, 80, 42, 42),
    Color.fromARGB(255, 129, 46, 46),
    Color.fromARGB(255, 177, 46, 46),
    Color.fromARGB(255, 219, 37, 37),
  ],
  'white': [
    Color.fromARGB(255, 99, 103, 143),
    Color.fromARGB(255, 144, 148, 187),
    Color.fromARGB(255, 167, 169, 189),
    Color.fromARGB(255, 220, 221, 236),
  ],
  'blue': [
    Color.fromARGB(255, 62, 67, 134),
    Color.fromARGB(255, 70, 78, 180),
    Color.fromARGB(255, 104, 112, 226),
    Color.fromARGB(255, 166, 170, 238),
  ],
};
*/