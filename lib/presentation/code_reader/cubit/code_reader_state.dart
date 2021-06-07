part of 'code_reader_cubit.dart';

@immutable
abstract class CodeReaderState {}

class CodeReaderInitial extends CodeReaderState {}

class CodeReaderStarted extends CodeReaderState {}

class CodeReaderScanned extends CodeReaderState {
  final QrCode code;

  CodeReaderScanned(this.code);
}
