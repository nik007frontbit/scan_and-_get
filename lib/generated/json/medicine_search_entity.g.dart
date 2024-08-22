import 'package:scan_and_get_images/generated/json/base/json_convert_content.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/medicine_search_entity.dart';

MedicineSearchEntity $MedicineSearchEntityFromJson(Map<String, dynamic> json) {
  final MedicineSearchEntity medicineSearchEntity = MedicineSearchEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    medicineSearchEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    medicineSearchEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    medicineSearchEntity.datetime = datetime;
  }
  final String? ngVersion = jsonConvert.convert<String>(json['ng_version']);
  if (ngVersion != null) {
    medicineSearchEntity.ngVersion = ngVersion;
  }
  final MedicineSearchData? data = jsonConvert.convert<MedicineSearchData>(
      json['data']);
  if (data != null) {
    medicineSearchEntity.data = data;
  }
  return medicineSearchEntity;
}

Map<String, dynamic> $MedicineSearchEntityToJson(MedicineSearchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['ng_version'] = entity.ngVersion;
  data['data'] = entity.data?.toJson();
  return data;
}

extension MedicineSearchEntityExtension on MedicineSearchEntity {
  MedicineSearchEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    String? ngVersion,
    MedicineSearchData? data,
  }) {
    return MedicineSearchEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..ngVersion = ngVersion ?? this.ngVersion
      ..data = data ?? this.data;
  }
}

MedicineSearchData $MedicineSearchDataFromJson(Map<String, dynamic> json) {
  final MedicineSearchData medicineSearchData = MedicineSearchData();
  final MedicineSearchDataMedicines? medicines = jsonConvert.convert<
      MedicineSearchDataMedicines>(json['medicines']);
  if (medicines != null) {
    medicineSearchData.medicines = medicines;
  }
  final List<dynamic>? customers = (json['customers'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (customers != null) {
    medicineSearchData.customers = customers;
  }
  final List<dynamic>? distributors = (json['distributors'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (distributors != null) {
    medicineSearchData.distributors = distributors;
  }
  return medicineSearchData;
}

Map<String, dynamic> $MedicineSearchDataToJson(MedicineSearchData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['medicines'] = entity.medicines?.toJson();
  data['customers'] = entity.customers;
  data['distributors'] = entity.distributors;
  return data;
}

extension MedicineSearchDataExtension on MedicineSearchData {
  MedicineSearchData copyWith({
    MedicineSearchDataMedicines? medicines,
    List<dynamic>? customers,
    List<dynamic>? distributors,
  }) {
    return MedicineSearchData()
      ..medicines = medicines ?? this.medicines
      ..customers = customers ?? this.customers
      ..distributors = distributors ?? this.distributors;
  }
}

MedicineSearchDataMedicines $MedicineSearchDataMedicinesFromJson(
    Map<String, dynamic> json) {
  final MedicineSearchDataMedicines medicineSearchDataMedicines = MedicineSearchDataMedicines();
  final String? searchType = jsonConvert.convert<String>(json['search_type']);
  if (searchType != null) {
    medicineSearchDataMedicines.searchType = searchType;
  }
  final List<dynamic>? didYouMeanResult = (json['did_you_mean_result'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (didYouMeanResult != null) {
    medicineSearchDataMedicines.didYouMeanResult = didYouMeanResult;
  }
  final List<
      MedicineSearchDataMedicinesResult>? result = (json['result'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MedicineSearchDataMedicinesResult>(
          e) as MedicineSearchDataMedicinesResult).toList();
  if (result != null) {
    medicineSearchDataMedicines.result = result;
  }
  return medicineSearchDataMedicines;
}

Map<String, dynamic> $MedicineSearchDataMedicinesToJson(
    MedicineSearchDataMedicines entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['search_type'] = entity.searchType;
  data['did_you_mean_result'] = entity.didYouMeanResult;
  data['result'] = entity.result?.map((v) => v.toJson()).toList();
  return data;
}

extension MedicineSearchDataMedicinesExtension on MedicineSearchDataMedicines {
  MedicineSearchDataMedicines copyWith({
    String? searchType,
    List<dynamic>? didYouMeanResult,
    List<MedicineSearchDataMedicinesResult>? result,
  }) {
    return MedicineSearchDataMedicines()
      ..searchType = searchType ?? this.searchType
      ..didYouMeanResult = didYouMeanResult ?? this.didYouMeanResult
      ..result = result ?? this.result;
  }
}

MedicineSearchDataMedicinesResult $MedicineSearchDataMedicinesResultFromJson(
    Map<String, dynamic> json) {
  final MedicineSearchDataMedicinesResult medicineSearchDataMedicinesResult = MedicineSearchDataMedicinesResult();
  final int? approved = jsonConvert.convert<int>(json['approved']);
  if (approved != null) {
    medicineSearchDataMedicinesResult.approved = approved;
  }
  final String? availableForPatient = jsonConvert.convert<String>(
      json['available_for_patient']);
  if (availableForPatient != null) {
    medicineSearchDataMedicinesResult.availableForPatient = availableForPatient;
  }
  final int? cessPercentage = jsonConvert.convert<int>(json['cess_percentage']);
  if (cessPercentage != null) {
    medicineSearchDataMedicinesResult.cessPercentage = cessPercentage;
  }
  final String? requestedByEntity = jsonConvert.convert<String>(
      json['requested_by_entity']);
  if (requestedByEntity != null) {
    medicineSearchDataMedicinesResult.requestedByEntity = requestedByEntity;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    medicineSearchDataMedicinesResult.content = content;
  }
  final String? dosageType = jsonConvert.convert<String>(json['dosage_type']);
  if (dosageType != null) {
    medicineSearchDataMedicinesResult.dosageType = dosageType;
  }
  final int? gstPercentage = jsonConvert.convert<int>(json['gst_percentage']);
  if (gstPercentage != null) {
    medicineSearchDataMedicinesResult.gstPercentage = gstPercentage;
  }
  final String? gtinNumber = jsonConvert.convert<String>(json['gtin_number']);
  if (gtinNumber != null) {
    medicineSearchDataMedicinesResult.gtinNumber = gtinNumber;
  }
  final String? hsnCode = jsonConvert.convert<String>(json['hsn_code']);
  if (hsnCode != null) {
    medicineSearchDataMedicinesResult.hsnCode = hsnCode;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    medicineSearchDataMedicinesResult.image = image;
  }
  final String? manufacturerName = jsonConvert.convert<String>(
      json['manufacturer_name']);
  if (manufacturerName != null) {
    medicineSearchDataMedicinesResult.manufacturerName = manufacturerName;
  }
  final int? medicineId = jsonConvert.convert<int>(json['medicine_id']);
  if (medicineId != null) {
    medicineSearchDataMedicinesResult.medicineId = medicineId;
  }
  final String? medicineName = jsonConvert.convert<String>(
      json['medicine_name']);
  if (medicineName != null) {
    medicineSearchDataMedicinesResult.medicineName = medicineName;
  }
  final String? medicineNameSuggest = jsonConvert.convert<String>(
      json['medicine_name_suggest']);
  if (medicineNameSuggest != null) {
    medicineSearchDataMedicinesResult.medicineNameSuggest = medicineNameSuggest;
  }
  final String? medicineType = jsonConvert.convert<String>(
      json['medicine_type']);
  if (medicineType != null) {
    medicineSearchDataMedicinesResult.medicineType = medicineType;
  }
  final int? mrp = jsonConvert.convert<int>(json['mrp']);
  if (mrp != null) {
    medicineSearchDataMedicinesResult.mrp = mrp;
  }
  final String? packSize = jsonConvert.convert<String>(json['pack_size']);
  if (packSize != null) {
    medicineSearchDataMedicinesResult.packSize = packSize;
  }
  final String? packingSize = jsonConvert.convert<String>(json['packing_size']);
  if (packingSize != null) {
    medicineSearchDataMedicinesResult.packingSize = packingSize;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    medicineSearchDataMedicinesResult.price = price;
  }
  final int? saltContentId = jsonConvert.convert<int>(json['salt_content_id']);
  if (saltContentId != null) {
    medicineSearchDataMedicinesResult.saltContentId = saltContentId;
  }
  final String? scheduleType = jsonConvert.convert<String>(
      json['schedule_type']);
  if (scheduleType != null) {
    medicineSearchDataMedicinesResult.scheduleType = scheduleType;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    medicineSearchDataMedicinesResult.size = size;
  }
  final String? slug = jsonConvert.convert<String>(json['slug']);
  if (slug != null) {
    medicineSearchDataMedicinesResult.slug = slug;
  }
  final int? popularityCount = jsonConvert.convert<int>(
      json['popularity_count']);
  if (popularityCount != null) {
    medicineSearchDataMedicinesResult.popularityCount = popularityCount;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    medicineSearchDataMedicinesResult.location = location;
  }
  final int? saleDiscount = jsonConvert.convert<int>(json['sale_discount']);
  if (saleDiscount != null) {
    medicineSearchDataMedicinesResult.saleDiscount = saleDiscount;
  }
  final int? saleB2bDiscount = jsonConvert.convert<int>(
      json['sale_b2b_discount']);
  if (saleB2bDiscount != null) {
    medicineSearchDataMedicinesResult.saleB2bDiscount = saleB2bDiscount;
  }
  final int? saleCount = jsonConvert.convert<int>(json['sale_count']);
  if (saleCount != null) {
    medicineSearchDataMedicinesResult.saleCount = saleCount;
  }
  final int? minQuantity = jsonConvert.convert<int>(json['min_quantity']);
  if (minQuantity != null) {
    medicineSearchDataMedicinesResult.minQuantity = minQuantity;
  }
  final int? maxQuantity = jsonConvert.convert<int>(json['max_quantity']);
  if (maxQuantity != null) {
    medicineSearchDataMedicinesResult.maxQuantity = maxQuantity;
  }
  final String? lockDiscount = jsonConvert.convert<String>(
      json['lock_discount']);
  if (lockDiscount != null) {
    medicineSearchDataMedicinesResult.lockDiscount = lockDiscount;
  }
  final String? lockB2bDiscount = jsonConvert.convert<String>(
      json['lock_b2b_discount']);
  if (lockB2bDiscount != null) {
    medicineSearchDataMedicinesResult.lockB2bDiscount = lockB2bDiscount;
  }
  final String? sellInLoose = jsonConvert.convert<String>(
      json['sell_in_loose']);
  if (sellInLoose != null) {
    medicineSearchDataMedicinesResult.sellInLoose = sellInLoose;
  }
  final String? directions = jsonConvert.convert<String>(json['directions']);
  if (directions != null) {
    medicineSearchDataMedicinesResult.directions = directions;
  }
  final int? inventoryId = jsonConvert.convert<int>(json['inventory_id']);
  if (inventoryId != null) {
    medicineSearchDataMedicinesResult.inventoryId = inventoryId;
  }
  final int? quantity = jsonConvert.convert<int>(json['quantity']);
  if (quantity != null) {
    medicineSearchDataMedicinesResult.quantity = quantity;
  }
  final String? discontinued = jsonConvert.convert<String>(
      json['discontinued']);
  if (discontinued != null) {
    medicineSearchDataMedicinesResult.discontinued = discontinued;
  }
  final String? addedToShortbook = jsonConvert.convert<String>(
      json['added_to_shortbook']);
  if (addedToShortbook != null) {
    medicineSearchDataMedicinesResult.addedToShortbook = addedToShortbook;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    medicineSearchDataMedicinesResult.level = level;
  }
  return medicineSearchDataMedicinesResult;
}

Map<String, dynamic> $MedicineSearchDataMedicinesResultToJson(
    MedicineSearchDataMedicinesResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['approved'] = entity.approved;
  data['available_for_patient'] = entity.availableForPatient;
  data['cess_percentage'] = entity.cessPercentage;
  data['requested_by_entity'] = entity.requestedByEntity;
  data['content'] = entity.content;
  data['dosage_type'] = entity.dosageType;
  data['gst_percentage'] = entity.gstPercentage;
  data['gtin_number'] = entity.gtinNumber;
  data['hsn_code'] = entity.hsnCode;
  data['image'] = entity.image;
  data['manufacturer_name'] = entity.manufacturerName;
  data['medicine_id'] = entity.medicineId;
  data['medicine_name'] = entity.medicineName;
  data['medicine_name_suggest'] = entity.medicineNameSuggest;
  data['medicine_type'] = entity.medicineType;
  data['mrp'] = entity.mrp;
  data['pack_size'] = entity.packSize;
  data['packing_size'] = entity.packingSize;
  data['price'] = entity.price;
  data['salt_content_id'] = entity.saltContentId;
  data['schedule_type'] = entity.scheduleType;
  data['size'] = entity.size;
  data['slug'] = entity.slug;
  data['popularity_count'] = entity.popularityCount;
  data['location'] = entity.location;
  data['sale_discount'] = entity.saleDiscount;
  data['sale_b2b_discount'] = entity.saleB2bDiscount;
  data['sale_count'] = entity.saleCount;
  data['min_quantity'] = entity.minQuantity;
  data['max_quantity'] = entity.maxQuantity;
  data['lock_discount'] = entity.lockDiscount;
  data['lock_b2b_discount'] = entity.lockB2bDiscount;
  data['sell_in_loose'] = entity.sellInLoose;
  data['directions'] = entity.directions;
  data['inventory_id'] = entity.inventoryId;
  data['quantity'] = entity.quantity;
  data['discontinued'] = entity.discontinued;
  data['added_to_shortbook'] = entity.addedToShortbook;
  data['level'] = entity.level;
  return data;
}

extension MedicineSearchDataMedicinesResultExtension on MedicineSearchDataMedicinesResult {
  MedicineSearchDataMedicinesResult copyWith({
    int? approved,
    String? availableForPatient,
    int? cessPercentage,
    String? requestedByEntity,
    String? content,
    String? dosageType,
    int? gstPercentage,
    String? gtinNumber,
    String? hsnCode,
    String? image,
    String? manufacturerName,
    int? medicineId,
    String? medicineName,
    String? medicineNameSuggest,
    String? medicineType,
    int? mrp,
    String? packSize,
    String? packingSize,
    int? price,
    int? saltContentId,
    String? scheduleType,
    int? size,
    String? slug,
    int? popularityCount,
    String? location,
    int? saleDiscount,
    int? saleB2bDiscount,
    int? saleCount,
    int? minQuantity,
    int? maxQuantity,
    String? lockDiscount,
    String? lockB2bDiscount,
    String? sellInLoose,
    String? directions,
    int? inventoryId,
    int? quantity,
    String? discontinued,
    String? addedToShortbook,
    String? level,
  }) {
    return MedicineSearchDataMedicinesResult()
      ..approved = approved ?? this.approved
      ..availableForPatient = availableForPatient ?? this.availableForPatient
      ..cessPercentage = cessPercentage ?? this.cessPercentage
      ..requestedByEntity = requestedByEntity ?? this.requestedByEntity
      ..content = content ?? this.content
      ..dosageType = dosageType ?? this.dosageType
      ..gstPercentage = gstPercentage ?? this.gstPercentage
      ..gtinNumber = gtinNumber ?? this.gtinNumber
      ..hsnCode = hsnCode ?? this.hsnCode
      ..image = image ?? this.image
      ..manufacturerName = manufacturerName ?? this.manufacturerName
      ..medicineId = medicineId ?? this.medicineId
      ..medicineName = medicineName ?? this.medicineName
      ..medicineNameSuggest = medicineNameSuggest ?? this.medicineNameSuggest
      ..medicineType = medicineType ?? this.medicineType
      ..mrp = mrp ?? this.mrp
      ..packSize = packSize ?? this.packSize
      ..packingSize = packingSize ?? this.packingSize
      ..price = price ?? this.price
      ..saltContentId = saltContentId ?? this.saltContentId
      ..scheduleType = scheduleType ?? this.scheduleType
      ..size = size ?? this.size
      ..slug = slug ?? this.slug
      ..popularityCount = popularityCount ?? this.popularityCount
      ..location = location ?? this.location
      ..saleDiscount = saleDiscount ?? this.saleDiscount
      ..saleB2bDiscount = saleB2bDiscount ?? this.saleB2bDiscount
      ..saleCount = saleCount ?? this.saleCount
      ..minQuantity = minQuantity ?? this.minQuantity
      ..maxQuantity = maxQuantity ?? this.maxQuantity
      ..lockDiscount = lockDiscount ?? this.lockDiscount
      ..lockB2bDiscount = lockB2bDiscount ?? this.lockB2bDiscount
      ..sellInLoose = sellInLoose ?? this.sellInLoose
      ..directions = directions ?? this.directions
      ..inventoryId = inventoryId ?? this.inventoryId
      ..quantity = quantity ?? this.quantity
      ..discontinued = discontinued ?? this.discontinued
      ..addedToShortbook = addedToShortbook ?? this.addedToShortbook
      ..level = level ?? this.level;
  }
}