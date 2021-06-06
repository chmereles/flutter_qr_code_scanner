import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qrcode_state.dart';

class QrcodeCubit extends Cubit<QrcodeState> {
  QrcodeCubit() : super(QrcodeInitial());

  void codeScanned(String code) {
    print(':::cubit:codeScanned($code)');
  }
}
