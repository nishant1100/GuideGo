// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingHiveModelAdapter extends TypeAdapter<BookingHiveModel> {
  @override
  final int typeId = 1;

  @override
  BookingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingHiveModel(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      guideId: fields[5] as dynamic,
      pickupDate: fields[2] as String,
      pickupTime: fields[3] as String,
      noofPeople: fields[4] as String,
      pickupType: fields[6] as String,
      pickupLocation: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookingHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.pickupDate)
      ..writeByte(3)
      ..write(obj.pickupTime)
      ..writeByte(4)
      ..write(obj.noofPeople)
      ..writeByte(5)
      ..write(obj.guideId)
      ..writeByte(6)
      ..write(obj.pickupType)
      ..writeByte(7)
      ..write(obj.pickupLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
