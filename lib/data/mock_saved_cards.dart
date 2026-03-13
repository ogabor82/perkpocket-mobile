import '../models/saved_card_model.dart';

const mockSavedCards = [
  SavedCardModel(
    id: 'saved-1',
    merchantName: 'COOP',
    label: 'Main grocery card',
    codeValue: '5991234567890',
    codeType: 'ean13',
    lastDigits: '7890',
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
    codeValue: '981234567890',
    codeType: 'ean13',
    lastDigits: '7890',
    brandHex: '#7C3AED',
  ),
];