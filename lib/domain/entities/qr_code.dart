enum IconsTypes { text, wifi, website, event, contact, email, phone, sms }

class QrCodeType {
  final String title;
  final IconsTypes iconType;

  QrCodeType({
    required this.title,
    required this.iconType,
  });
}

class QrCode {
  final String codeValue;
  final QrCodeType type;

  QrCode({
    required this.codeValue,
    required this.type,
  });

  @override
  String toString() {
    return '$type: $codeValue';
  }
}
