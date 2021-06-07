import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/domain/entities/qr_code.dart';

IconData getIconData(IconsTypes type) {
  switch (type) {
    case IconsTypes.website:
      return Icons.link;
    //
    case IconsTypes.wifi:
      return Icons.wifi;
    //
    case IconsTypes.event:
      return Icons.event;
    //
    case IconsTypes.contact:
      return Icons.contact_page;
    //
    case IconsTypes.email:
      return Icons.email;
    //
    case IconsTypes.phone:
      return Icons.phone;
    //
    case IconsTypes.sms:
      return Icons.sms;
    //
    default:
      return Icons.text_fields;
  }
}
