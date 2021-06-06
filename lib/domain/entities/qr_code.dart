class QrCodeType {}

class QrCode {
  final String value;
  final String pattern;
  final QrCodeType type;

  QrCode({
    required this.value,
    required this.pattern,
    required this.type,
  });
}
