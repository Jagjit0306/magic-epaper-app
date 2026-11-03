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

    test('NFC codec encodes red using the secondary color plane', () {
      final profile = WaveshareNfcProfile.fromType(8);
      final image = img.Image(width: 200, height: 200);
      image.clear(img.ColorRgb8(255, 0, 0));

      final encoded = WaveshareImageCodec().encode(profile, image);

      expect(profile.isHdDisplay, isTrue);
      expect(encoded.primary.take(5000).every((byte) => byte == 0), isTrue);
      expect(encoded.secondary.take(5000).any((byte) => byte != 0), isTrue);
    });
  });
}
