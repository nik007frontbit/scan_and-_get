class MedicineVerificationPendingModel {
  String image;
  String medicineId;
  String medicineName;
  String batchId;
  bool isVerified=false;

  MedicineVerificationPendingModel({
    required this.image,
    required this.medicineId,
    required this.medicineName,
    required this.batchId,
  });

  // Optional: A factory method for creating an instance from a map.
  factory MedicineVerificationPendingModel.fromMap(Map<String, dynamic> map) {
    return MedicineVerificationPendingModel(
      image: map['image'] ?? "",
      medicineId: map['medicine_id'] ?? "",
      medicineName: map['medicine_name'] ?? "",
      batchId: map['batch_id'] ?? "",
    );
  }

  // Optional: A method to convert an instance back to a map.
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'medicine_id': medicineId,
      'medicine_name': medicineName,
      'batch_id': batchId,
    };
  }
}
