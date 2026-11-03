import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:magicepaperapp/image_library/utils/epd_utils.dart';
import 'package:magicepaperapp/utils/epd/waveshare_displays.dart';
import 'package:magicepaperapp/utils/image_processing/image_processing.dart';
import 'package:magicepaperapp/waveshare/models/waveshare_nfc_profile.dart';
import 'package:magicepaperapp/waveshare/services/waveshare_image_codec.dart';

void main() {
  group('Waveshare 1.54" NFC display', () {
    test('is available as a 200x200 red, black, and white display', () {
      final display = Waveshare1in54();

      expect(display.width, 200);
      expect(display.height, 200);
      expect(display.colors, [Colors.white, Colors.black, Colors.red]);
      expect(display.isBeta, isFalse);
      expect(
        display.processingMethods,
        [
          ImageProcessing.bwrFloydSteinbergDither,
          ImageProcessing.bwrFalseFloydSteinbergDither,
          ImageProcessing.bwrStuckiDither,
          ImageProcessing.bwrTriColorAtkinsonDither,
          ImageProcessing.bwrHalftone,
          ImageProcessing.bwrThreshold,
          ImageProcessing.bwrBayerDither,
          ImageProcessing.bwrSierra2Dither,
          ImageProcessing.bwrBurkesDither,
        ],
      );
    });

    test('restores from saved device metadata', () {
      expect(
        EpdUtils.getEpdFromMetadata({'epdModel': '17953'}),
        isA<Waveshare1in54>(),
      );
    });

    test('NFC codec keeps red pixels out of the black color plane', () {
      final profile = WaveshareNfcProfile.fromType(8);
      final image = img.Image(width: 200, height: 200);
      for (var y = 0; y < image.height; y++) {
        for (var x = 0; x < image.width; x++) {
          if (x < 64) {
            image.setPixelRgb(x, y, 0, 0, 0);
          } else if (x < 128) {
            image.setPixelRgb(x, y, 255, 0, 0);
          } else {
            image.setPixelRgb(x, y, 255, 255, 255);
          }
        }
      }

      final encoded = WaveshareImageCodec().encode(profile, image);
      const sampleX = 80;
      const sampleY = 100;
      final sampleIndex = sampleY * profile.displayWidth + sampleX;
      final sampleByte = sampleIndex ~/ 8;
      final sampleMask = 0x80 >> (sampleIndex % 8);

      expect(profile.isHdDisplay, isTrue);
      expect(encoded.primary[sampleByte] & sampleMask, isNonZero);
      expect(encoded.secondary[sampleByte] & sampleMask, isNonZero);

      final blackIndex = sampleY * profile.displayWidth + 20;
      final blackByte = blackIndex ~/ 8;
      final blackMask = 0x80 >> (blackIndex % 8);
      expect(encoded.primary[blackByte] & blackMask, 0);
      expect(encoded.secondary[blackByte] & blackMask, 0);

      final whiteIndex = sampleY * profile.displayWidth + 160;
      final whiteByte = whiteIndex ~/ 8;
      final whiteMask = 0x80 >> (whiteIndex % 8);
      expect(encoded.primary[whiteByte] & whiteMask, isNonZero);
      expect(encoded.secondary[whiteByte] & whiteMask, 0);
    });
  });
}
