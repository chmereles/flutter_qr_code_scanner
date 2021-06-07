import 'package:qr_code_scanner/domain/entities/qr_code.dart';

class QrCodeModel extends QrCode {
  QrCodeModel({
    required String codeValue,
    required QrCodeType type,
  }) : super(codeValue: codeValue, type: type);

  // final textCode = QrCodeType(title: 'TEXTO', iconData: Icons.text_fields);
  // final webSiteCode = QrCodeType(title: 'SITIO WEB', iconData: Icons.link);
  // final wifiCode = QrCodeType(title: 'WIFI', iconData: Icons.wifi);
  // final eventCode =
  //     QrCodeType(title: 'EVENTO', iconData: Icons.calendar_today);
  // final contactCode =
  //     QrCodeType(title: 'CONTACTO', iconData: Icons.contact_page);
  // final phoneCode = QrCodeType(title: 'TELEFONO', iconData: Icons.phone);
  // final smsCode = QrCodeType(title: 'SMS', iconData: Icons.sms);

  static QrCodeType _getTypeCode(String code) {
    if (code.isWifi) {
      return QrCodeType(
        title: 'Wifi',
        iconType: IconsTypes.wifi,
      );
    }
    if (code.isWebSite) {
      return QrCodeType(
        title: 'Sitio Web',
        iconType: IconsTypes.website,
      );
    }
    if (code.isEvent) {
      return QrCodeType(
        title: 'Evento',
        iconType: IconsTypes.event,
      );
    }
    if (code.isContact) {
      return QrCodeType(
        title: 'Contacto',
        iconType: IconsTypes.contact,
      );
    }
    if (code.isEmail) {
      return QrCodeType(
        title: 'Email',
        iconType: IconsTypes.email,
      );
    }
    if (code.isPhone) {
      return QrCodeType(
        title: 'Telefono',
        iconType: IconsTypes.phone,
      );
    }
    if (code.isSms) {
      return QrCodeType(
        title: 'SMS',
        iconType: IconsTypes.sms,
      );
    }
    return QrCodeType(
      title: 'Texto',
      iconType: IconsTypes.text,
    );
  }

  factory QrCodeModel.fromString(String str) {
    final type = _getTypeCode(str);

    return QrCodeModel(
      codeValue: str,
      type: type,
    );
  }
}

extension FancyNum on String {
  bool get isWifi {
    return this.length >= 5 && this.substring(0, 5).toLowerCase() == 'wifi:';
  }

  bool get isWebSite {
    const urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    final regExp = RegExp(urlPattern, caseSensitive: false);

    return regExp.hasMatch(this);
  }

  bool _matchWithPattern(String pattern) {
    final int patternLength = pattern.length;

    return this.length >= patternLength &&
        this.substring(0, patternLength).toLowerCase() == pattern;
  }

  bool get isEvent {
    return _matchWithPattern('begin:vcalendar');
  }

  bool get isContact {
    return _matchWithPattern('begin:vcard');
  }

  bool get isEmail {
    return _matchWithPattern('mailto:');
  }

  bool get isPhone {
    return _matchWithPattern('tel:');
  }

  bool get isSms {
    return _matchWithPattern('smsto:');
  }
}
