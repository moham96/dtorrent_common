import 'package:dtorrent_common/dtorrent_common.dart';
import 'package:test/test.dart';

void main() {
  group('randomBytes', () {
    test('returns correct length (typedList=false)', () {
      var bytes = randomBytes(10);
      expect(bytes.length, 10);
      expect(bytes, isA<List<int>>());
    });
    test('returns correct length (typedList=true)', () {
      var bytes = randomBytes(10, true);
      expect(bytes.length, 10);
      expect(bytes, isA<List<int>>());
    });
    test('returns empty for zero length', () {
      expect(randomBytes(0), isEmpty);
      expect(randomBytes(0, true), isEmpty);
    });
    test('values are in 0-255', () {
      var bytes = randomBytes(100);
      expect(bytes.every((b) => b >= 0 && b <= 255), isTrue);
    });
  });

  group('randomInt', () {
    test('returns value in range', () {
      for (var i = 1; i < 100; i++) {
        var value = randomInt(i);
        expect(value, inInclusiveRange(0, i - 1));
      }
    });
    test('throws for max=0', () {
      expect(() => randomInt(0), throwsA(isA<RangeError>()));
    });
  });

  group('transformBufferToHexString', () {
    test('empty buffer returns empty string', () {
      expect(transformBufferToHexString([]), '');
    });
    test('single byte', () {
      expect(transformBufferToHexString([15]), '0f');
      expect(transformBufferToHexString([255]), 'ff');
    });
    test('multiple bytes', () {
      expect(transformBufferToHexString([1, 2, 3, 255]), '010203ff');
    });
  });
}
