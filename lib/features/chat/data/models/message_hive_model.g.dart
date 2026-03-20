// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageHiveModelAdapter extends TypeAdapter<MessageHiveModel> {
  @override
  final int typeId = 0;

  @override
  MessageHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageHiveModel(
      id: fields[0] as String,
      text: fields[1] as String,
      sender: fields[2] as String,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
