// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:scan_and_get_images/screen/batch_reader/model/address_search_model_entity.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_model_entity.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_thread_entity.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/medicine_search_entity.dart';

JsonConvert jsonConvert = JsonConvert();

typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);
typedef ConvertExceptionHandler = void Function(Object error, StackTrace stackTrace);
extension MapSafeExt<K, V> on Map<K, V> {
  T? getOrNull<T>(K? key) {
    if (!containsKey(key) || key == null) {
      return null;
    } else {
      return this[key] as T?;
    }
  }
}

class JsonConvert {
  static ConvertExceptionHandler? onError;
  JsonConvertClassCollection convertFuncMap = JsonConvertClassCollection();

  /// When you are in the development, to generate a new model class, hot-reload doesn't find new generation model class, you can build on MaterialApp method called jsonConvert. ReassembleConvertFuncMap (); This method only works in a development environment
  /// https://flutter.cn/docs/development/tools/hot-reload
  /// class MyApp extends StatelessWidget {
  ///    const MyApp({Key? key})
  ///        : super(key: key);
  ///
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      jsonConvert.reassembleConvertFuncMap();
  ///      return MaterialApp();
  ///    }
  /// }
  void reassembleConvertFuncMap() {
    bool isReleaseMode = const bool.fromEnvironment('dart.vm.product');
    if (!isReleaseMode) {
      convertFuncMap = JsonConvertClassCollection();
    }
  }

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e, enumConvert: enumConvert))
          .toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) =>
      _asT<T>(e, enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        var covertFunc = convertFuncMap[type]!;
        if (covertFunc is Map<String, dynamic>) {
          return covertFunc(value as Map<String, dynamic>) as T;
        } else {
          return covertFunc(Map<String, dynamic>.from(value)) as T;
        }
      } else {
        throw UnimplementedError(
            '$type unimplemented,you can try running the app again');
      }
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<AddressSearchModelEntity>[] is M) {
      return data.map<AddressSearchModelEntity>((Map<String, dynamic> e) =>
          AddressSearchModelEntity.fromJson(e)).toList() as M;
    }
    if (<AddressSearchModelData>[] is M) {
      return data.map<AddressSearchModelData>((Map<String, dynamic> e) =>
          AddressSearchModelData.fromJson(e)).toList() as M;
    }
    if (<AddressSearchModelDataResult>[] is M) {
      return data.map<AddressSearchModelDataResult>((Map<String, dynamic> e) =>
          AddressSearchModelDataResult.fromJson(e)).toList() as M;
    }
    if (<BatchReaderModelEntity>[] is M) {
      return data.map<BatchReaderModelEntity>((Map<String, dynamic> e) =>
          BatchReaderModelEntity.fromJson(e)).toList() as M;
    }
    if (<BatchReaderModelData>[] is M) {
      return data.map<BatchReaderModelData>((Map<String, dynamic> e) =>
          BatchReaderModelData.fromJson(e)).toList() as M;
    }
    if (<BatchReaderThreadEntity>[] is M) {
      return data.map<BatchReaderThreadEntity>((Map<String, dynamic> e) =>
          BatchReaderThreadEntity.fromJson(e)).toList() as M;
    }
    if (<BatchReaderThreadData>[] is M) {
      return data.map<BatchReaderThreadData>((Map<String, dynamic> e) =>
          BatchReaderThreadData.fromJson(e)).toList() as M;
    }
    if (<MedicineSearchEntity>[] is M) {
      return data.map<MedicineSearchEntity>((Map<String, dynamic> e) =>
          MedicineSearchEntity.fromJson(e)).toList() as M;
    }
    if (<MedicineSearchData>[] is M) {
      return data.map<MedicineSearchData>((Map<String, dynamic> e) =>
          MedicineSearchData.fromJson(e)).toList() as M;
    }
    if (<MedicineSearchDataMedicines>[] is M) {
      return data.map<MedicineSearchDataMedicines>((Map<String, dynamic> e) =>
          MedicineSearchDataMedicines.fromJson(e)).toList() as M;
    }
    if (<MedicineSearchDataMedicinesResult>[] is M) {
      return data.map<MedicineSearchDataMedicinesResult>((
          Map<String, dynamic> e) =>
          MedicineSearchDataMedicinesResult.fromJson(e)).toList() as M;
    }

    debugPrint("$M not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is M) {
      return json;
    }
    if (json is List) {
      return _getListChildType<M>(
          json.map((dynamic e) => e as Map<String, dynamic>).toList());
    } else {
      return jsonConvert.convert<M>(json);
    }
  }
}

class JsonConvertClassCollection {
  Map<String, JsonConvertFunction> convertFuncMap = {
    (AddressSearchModelEntity).toString(): AddressSearchModelEntity.fromJson,
    (AddressSearchModelData).toString(): AddressSearchModelData.fromJson,
    (AddressSearchModelDataResult).toString(): AddressSearchModelDataResult
        .fromJson,
    (BatchReaderModelEntity).toString(): BatchReaderModelEntity.fromJson,
    (BatchReaderModelData).toString(): BatchReaderModelData.fromJson,
    (BatchReaderThreadEntity).toString(): BatchReaderThreadEntity.fromJson,
    (BatchReaderThreadData).toString(): BatchReaderThreadData.fromJson,
    (MedicineSearchEntity).toString(): MedicineSearchEntity.fromJson,
    (MedicineSearchData).toString(): MedicineSearchData.fromJson,
    (MedicineSearchDataMedicines).toString(): MedicineSearchDataMedicines
        .fromJson,
    (MedicineSearchDataMedicinesResult)
        .toString(): MedicineSearchDataMedicinesResult.fromJson,
  };

  bool containsKey(String type) {
    return convertFuncMap.containsKey(type);
  }

  JsonConvertFunction? operator [](String key) {
    return convertFuncMap[key];
  }
}