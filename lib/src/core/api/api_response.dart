// {
//     "status_code": 1,
//     "status_message": "Table of content fetched successfully",
//     "data": [
//         [
//             [
//                 "Vitamin D3",
//                 "IP",
//                 "1000 IU",
//                 ""
//             ],
//             [
//                 "Vitamin B6",
//                 "IP",
//                 "1.5 mg",
//                 ""
//             ],
//             [
//                 "Methylcobalamin",
//                 "IP",
//                 "500 mcg",
//                 ""
//             ],
//             [
//                 "Niacinamide",
//                 "IP",
//                 "50 mg",
//                 "Colour: Approved colours used."
//             ],
//             [
//                 "Folic acid",
//                 "IP",
//                 "1.5 mg",
//                 "Appropriate overages of"
//             ],
//             [
//                 "Chromium Picolinate",
//                 "USP",
//                 "250 mcg",
//                 "vitamins added to compensate"
//             ],
//             [
//                 "Sodium molybdate",
//                 "USP",
//                 "25 mcg",
//                 "the loss on storage."
//             ],
//             [
//                 "Manganese sulphate",
//                 "USP",
//                 "1.5 mg",
//                 "Dosage: As directed by the Physician."
//             ],
//             [
//                 "Zinc sulphate monohydrate",
//                 "IP",
//                 "55 mg",
//                 "Storage: Store in a cool,"
//             ],
//             [
//                 "Copper sulphate",
//                 "USP",
//                 "2 mg",
//                 "dry & dark place. Protect"
//             ],
//             [
//                 "Sodium selenite",
//                 "USP",
//                 "70 mcg",
//                 "from light."
//             ],
//             [
//                 "Magnesium oxide",
//                 "IP",
//                 "50 mg",
//                 "Keep out of reach of children."
//             ],
//             [
//                 "Mixed carotenoids 20%",
//                 "Powder",
//                 "11 mg",
//                 "For Therapeutic use only."
//             ]
//         ]
//     ]
// }
class ApiResponse {
  final int statusCode;
  final String statusMessage;
  final dynamic data;

  ApiResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": data,
  };
}
