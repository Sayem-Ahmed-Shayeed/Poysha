// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_scheme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrColorSchemeAdapter extends TypeAdapter<CurrColorScheme> {
  @override
  final int typeId = 0;

  @override
  CurrColorScheme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrColorScheme(
      schemeName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrColorScheme obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.schemeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrColorSchemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
