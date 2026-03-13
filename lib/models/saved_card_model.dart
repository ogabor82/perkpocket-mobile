class SavedCardModel {
  final String id;
  final String merchantName;
  final String label;
  final String codeValue;
  final String codeType;
  final String lastDigits;
  final String brandHex;

  const SavedCardModel({
    required this.id,
    required this.merchantName,
    required this.label,
    required this.codeValue,
    required this.codeType,
    required this.lastDigits,
    required this.brandHex,
  });
}