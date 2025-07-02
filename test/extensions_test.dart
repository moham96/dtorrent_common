import 'package:dtorrent_common/dtorrent_common.dart';
import 'package:test/test.dart';

void main() {
  group('IntExtension.toHexString', () {
    test('converts 0 to 00', () {
      expect(0.toHexString(), '00');
    });
    test('converts 15 to 0f', () {
      expect(15.toHexString(), '0f');
    });
    test('converts 255 to ff', () {
      expect(255.toHexString(), 'ff');
    });
    test('converts 256 to 100', () {
      expect(256.toHexString(), '100');
    });
  });

  group('IterableExtensions.toHexString', () {
    test('empty iterable returns empty string', () {
      expect(<int>[].toHexString(), '');
      expect(<int>[].toHexString(empty: 'none'), 'none');
    });
    test('single value', () {
      expect([15].toHexString(), '0f');
    });
    test('multiple values', () {
      expect([1, 2, 255].toHexString(), '0102ff');
    });
    test('with separator', () {
      expect([1, 2, 255].toHexString(separator: ':'), '01:02:ff');
    });
    test('with empty and separator', () {
      expect(<int>[].toHexString(empty: 'empty', separator: ':'), 'empty');
    });
  });
}
