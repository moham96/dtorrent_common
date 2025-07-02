import 'package:dtorrent_common/dtorrent_common.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('CompactAddress IPv6', () {
    test('parseIPv6Address and toBytes', () {
      var address = InternetAddress('2001:db8::1');
      var port = 6881;
      var compact = CompactAddress(address, port);
      var bytes = compact.toBytes();
      var parsed = CompactAddress.parseIPv6Address(bytes);
      expect(parsed, isNotNull);
      expect(parsed!.address, address);
      expect(parsed.port, port);
      expect(parsed, equals(compact));
      expect(parsed.hashCode, equals(compact.hashCode));
    });

    test('parseIPv6Addresses', () {
      var address1 = CompactAddress(InternetAddress('2001:db8::1'), 6881);
      var address2 = CompactAddress(InternetAddress('2001:db8::2'), 6882);
      var bytes = <int>[];
      bytes.addAll(address1.toBytes(false));
      bytes.addAll(address2.toBytes(false));
      var list = CompactAddress.parseIPv6Addresses(bytes);
      expect(list.length, 2);
      expect(list[0], equals(address1));
      expect(list[1], equals(address2));
    });

    test('parseIPv6Address with invalid length returns null', () {
      var bytes = List<int>.filled(10, 0);
      expect(CompactAddress.parseIPv6Address(bytes), isNull);
    });
  });

  group('CompactAddress equality and hashCode', () {
    test('equality and hashCode', () {
      var a1 = CompactAddress(InternetAddress('127.0.0.1'), 8080);
      var a2 = CompactAddress(InternetAddress('127.0.0.1'), 8080);
      var a3 = CompactAddress(InternetAddress('127.0.0.1'), 8081);
      expect(a1, equals(a2));
      expect(a1.hashCode, equals(a2.hashCode));
      expect(a1 == a3, isFalse);
    });
  });

  group('CompactAddress edge cases', () {
    test('parseIPv4Address with invalid length returns null', () {
      var bytes = List<int>.filled(3, 0);
      expect(CompactAddress.parseIPv4Address(bytes), isNull);
    });
  });
}
