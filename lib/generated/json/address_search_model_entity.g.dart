import 'package:scan_and_get_images/generated/json/base/json_convert_content.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/address_search_model_entity.dart';

AddressSearchModelEntity $AddressSearchModelEntityFromJson(
    Map<String, dynamic> json) {
  final AddressSearchModelEntity addressSearchModelEntity = AddressSearchModelEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    addressSearchModelEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    addressSearchModelEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    addressSearchModelEntity.datetime = datetime;
  }
  final String? ngVersion = jsonConvert.convert<String>(json['ng_version']);
  if (ngVersion != null) {
    addressSearchModelEntity.ngVersion = ngVersion;
  }
  final AddressSearchModelData? data = jsonConvert.convert<
      AddressSearchModelData>(json['data']);
  if (data != null) {
    addressSearchModelEntity.data = data;
  }
  return addressSearchModelEntity;
}

Map<String, dynamic> $AddressSearchModelEntityToJson(
    AddressSearchModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['ng_version'] = entity.ngVersion;
  data['data'] = entity.data.toJson();
  return data;
}

extension AddressSearchModelEntityExtension on AddressSearchModelEntity {
  AddressSearchModelEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    String? ngVersion,
    AddressSearchModelData? data,
  }) {
    return AddressSearchModelEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..ngVersion = ngVersion ?? this.ngVersion
      ..data = data ?? this.data;
  }
}

AddressSearchModelData $AddressSearchModelDataFromJson(
    Map<String, dynamic> json) {
  final AddressSearchModelData addressSearchModelData = AddressSearchModelData();
  final String? searchType = jsonConvert.convert<String>(json['search_type']);
  if (searchType != null) {
    addressSearchModelData.searchType = searchType;
  }
  final List<dynamic>? didYouMeanResult = (json['did_you_mean_result'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (didYouMeanResult != null) {
    addressSearchModelData.didYouMeanResult = didYouMeanResult;
  }
  final List<AddressSearchModelDataResult>? result = (json['result'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AddressSearchModelDataResult>(
          e) as AddressSearchModelDataResult).toList();
  if (result != null) {
    addressSearchModelData.result = result;
  }
  return addressSearchModelData;
}

Map<String, dynamic> $AddressSearchModelDataToJson(
    AddressSearchModelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['search_type'] = entity.searchType;
  data['did_you_mean_result'] = entity.didYouMeanResult;
  data['result'] = entity.result.map((v) => v.toJson()).toList();
  return data;
}

extension AddressSearchModelDataExtension on AddressSearchModelData {
  AddressSearchModelData copyWith({
    String? searchType,
    List<dynamic>? didYouMeanResult,
    List<AddressSearchModelDataResult>? result,
  }) {
    return AddressSearchModelData()
      ..searchType = searchType ?? this.searchType
      ..didYouMeanResult = didYouMeanResult ?? this.didYouMeanResult
      ..result = result ?? this.result;
  }
}

AddressSearchModelDataResult $AddressSearchModelDataResultFromJson(
    Map<String, dynamic> json) {
  final AddressSearchModelDataResult addressSearchModelDataResult = AddressSearchModelDataResult();
  final int? approved = jsonConvert.convert<int>(json['approved']);
  if (approved != null) {
    addressSearchModelDataResult.approved = approved;
  }
  final String? availableForPatient = jsonConvert.convert<String>(
      json['available_for_patient']);
  if (availableForPatient != null) {
    addressSearchModelDataResult.availableForPatient = availableForPatient;
  }
  final int? cessPercentage = jsonConvert.convert<int>(json['cess_percentage']);
  if (cessPercentage != null) {
    addressSearchModelDataResult.cessPercentage = cessPercentage;
  }
  final String? requestedByEntity = jsonConvert.convert<String>(
      json['requested_by_entity']);
  if (requestedByEntity != null) {
    addressSearchModelDataResult.requestedByEntity = requestedByEntity;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    addressSearchModelDataResult.content = content;
  }
  final String? dosageType = jsonConvert.convert<String>(json['dosage_type']);
  if (dosageType != null) {
    addressSearchModelDataResult.dosageType = dosageType;
  }
  final int? gstPercentage = jsonConvert.convert<int>(json['gst_percentage']);
  if (gstPercentage != null) {
    addressSearchModelDataResult.gstPercentage = gstPercentage;
  }
  final String? gtinNumber = jsonConvert.convert<String>(json['gtin_number']);
  if (gtinNumber != null) {
    addressSearchModelDataResult.gtinNumber = gtinNumber;
  }
  final String? hsnCode = jsonConvert.convert<String>(json['hsn_code']);
  if (hsnCode != null) {
    addressSearchModelDataResult.hsnCode = hsnCode;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    addressSearchModelDataResult.image = image;
  }
  final String? manufacturerName = jsonConvert.convert<String>(
      json['manufacturer_name']);
  if (manufacturerName != null) {
    addressSearchModelDataResult.manufacturerName = manufacturerName;
  }
  final int? medicineId = jsonConvert.convert<int>(json['medicine_id']);
  if (medicineId != null) {
    addressSearchModelDataResult.medicineId = medicineId;
  }
  final String? medicineName = jsonConvert.convert<String>(
      json['medicine_name']);
  if (medicineName != null) {
    addressSearchModelDataResult.medicineName = medicineName;
  }
  final String? medicineNameSuggest = jsonConvert.convert<String>(
      json['medicine_name_suggest']);
  if (medicineNameSuggest != null) {
    addressSearchModelDataResult.medicineNameSuggest = medicineNameSuggest;
  }
  final String? medicineType = jsonConvert.convert<String>(
      json['medicine_type']);
  if (medicineType != null) {
    addressSearchModelDataResult.medicineType = medicineType;
  }
  final int? mrp = jsonConvert.convert<int>(json['mrp']);
  if (mrp != null) {
    addressSearchModelDataResult.mrp = mrp;
  }
  final String? packSize = jsonConvert.convert<String>(json['pack_size']);
  if (packSize != null) {
    addressSearchModelDataResult.packSize = packSize;
  }
  final String? packingSize = jsonConvert.convert<String>(json['packing_size']);
  if (packingSize != null) {
    addressSearchModelDataResult.packingSize = packingSize;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    addressSearchModelDataResult.price = price;
  }
  final int? saltContentId = jsonConvert.convert<int>(json['salt_content_id']);
  if (saltContentId != null) {
    addressSearchModelDataResult.saltContentId = saltContentId;
  }
  final String? scheduleType = jsonConvert.convert<String>(
      json['schedule_type']);
  if (scheduleType != null) {
    addressSearchModelDataResult.scheduleType = scheduleType;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    addressSearchModelDataResult.size = size;
  }
  final String? slug = jsonConvert.convert<String>(json['slug']);
  if (slug != null) {
    addressSearchModelDataResult.slug = slug;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    addressSearchModelDataResult.location = location;
  }
  final int? saleDiscount = jsonConvert.convert<int>(json['sale_discount']);
  if (saleDiscount != null) {
    addressSearchModelDataResult.saleDiscount = saleDiscount;
  }
  final int? saleB2bDiscount = jsonConvert.convert<int>(
      json['sale_b2b_discount']);
  if (saleB2bDiscount != null) {
    addressSearchModelDataResult.saleB2bDiscount = saleB2bDiscount;
  }
  final int? saleCount = jsonConvert.convert<int>(json['sale_count']);
  if (saleCount != null) {
    addressSearchModelDataResult.saleCount = saleCount;
  }
  final int? minQuantity = jsonConvert.convert<int>(json['min_quantity']);
  if (minQuantity != null) {
    addressSearchModelDataResult.minQuantity = minQuantity;
  }
  final int? maxQuantity = jsonConvert.convert<int>(json['max_quantity']);
  if (maxQuantity != null) {
    addressSearchModelDataResult.maxQuantity = maxQuantity;
  }
  final String? lockDiscount = jsonConvert.convert<String>(
      json['lock_discount']);
  if (lockDiscount != null) {
    addressSearchModelDataResult.lockDiscount = lockDiscount;
  }
  final String? lockB2bDiscount = jsonConvert.convert<String>(
      json['lock_b2b_discount']);
  if (lockB2bDiscount != null) {
    addressSearchModelDataResult.lockB2bDiscount = lockB2bDiscount;
  }
  final String? sellInLoose = jsonConvert.convert<String>(
      json['sell_in_loose']);
  if (sellInLoose != null) {
    addressSearchModelDataResult.sellInLoose = sellInLoose;
  }
  final String? directions = jsonConvert.convert<String>(json['directions']);
  if (directions != null) {
    addressSearchModelDataResult.directions = directions;
  }
  final int? inventoryId = jsonConvert.convert<int>(json['inventory_id']);
  if (inventoryId != null) {
    addressSearchModelDataResult.inventoryId = inventoryId;
  }
  final int? quantity = jsonConvert.convert<int>(json['quantity']);
  if (quantity != null) {
    addressSearchModelDataResult.quantity = quantity;
  }
  final String? discontinued = jsonConvert.convert<String>(
      json['discontinued']);
  if (discontinued != null) {
    addressSearchModelDataResult.discontinued = discontinued;
  }
  return addressSearchModelDataResult;
}

Map<String, dynamic> $AddressSearchModelDataResultToJson(
    AddressSearchModelDataResult entity) {
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
  return data;
}

extension AddressSearchModelDataResultExtension on AddressSearchModelDataResult {
  AddressSearchModelDataResult copyWith({
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
  }) {
    return AddressSearchModelDataResult()
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
      ..discontinued = discontinued ?? this.discontinued;
  }
}