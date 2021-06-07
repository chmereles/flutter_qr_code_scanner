import 'package:bloc/bloc.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:meta/meta.dart';
import 'package:qr_code_scanner/data/models/qr_code_model.dart';
import 'package:qr_code_scanner/domain/entities/qr_code.dart';

part 'code_reader_state.dart';

class CodeReaderCubit extends Cubit<CodeReaderState> {
  CodeReaderCubit() : super(CodeReaderInitial());

  QrReaderViewController? _controller;

  void onCreateController(QrReaderViewController controller) async {
    _controller = controller;
    startScan();
  }

  bool isScan = false;

  Future<void> startScan() async {
    isScan = false;
    await _controller?.startCamera(_onQrBack);
    // _initAnimation();
  }

  Future _onQrBack(data, _) async {
    if (isScan == true) return;
    isScan = true;
    stopScan();
    // await widget.onScan(data);
    codeScanned(data);
  }

  void stopScan() {
    _controller?.stopCamera();
    // _clearAnimation();
  }

  Future scanImage() async {
    stopScan();
    // var image = await ImagePicker().getImage(source: ImageSource.gallery);
    // if (image == null) {
    //   startScan();
    //   return;
    // }
    // final rest = await FlutterQrReader.imgScan(image.path);
    final rest =
        // await Future.value('WIFI:S:Zhone_DB01;T:WPA;P:znid311655937;H:false;');
        await Future.value('tel:3834684050');
    // await Future.value('begin:vcalendar');
    // await widget.onScan(rest);
    codeScanned(rest);
    // startScan();
  }

  Future<void> start() async {
    await startScan();
    emit(CodeReaderStarted());
  }

  void codeScanned(String code) {
    emit(CodeReaderScanned(QrCodeModel.fromString(code)));
  }
}
