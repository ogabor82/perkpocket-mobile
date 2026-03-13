import '../models/saved_card_model.dart';

const mockSavedCards = [
  SavedCardModel(
    id: 'saved-1',
    merchantName: 'COOP',
    label: 'Main grocery card',
    codeValue: '5991234567894',
    codeType: 'ean13',
    lastDigits: '7894',
    brandHex: '#D62828',
  ),
  SavedCardModel(
    id: 'saved-2',
    merchantName: 'Hervis',
    label: 'Sports membership',
    codeValue: '204500998877',
    codeType: 'code128',
    lastDigits: '8877',
    brandHex: '#1D4ED8',
  ),
  SavedCardModel(
    id: 'saved-3',
    merchantName: 'BookPoint',
    label: 'Book club card',
    codeValue: '9812345678902',
    codeType: 'ean13',
    lastDigits: '8902',
    brandHex: '#7C3AED',
  ),
];