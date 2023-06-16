String convertToArabic(String provinceName) {
  switch (provinceName) {
    case 'Aleppo':
      return 'حلب';
    case 'Damascus':
      return 'دمشق';
    case 'Deir ez-Zor':
      return 'دير الزور';
    case 'Hama':
      return 'حماة';
    case 'Homs':
      return 'حمص';
    case 'Idlib':
      return 'إدلب';
    case 'Latakia':
      return 'اللاذقية';
    case 'Quneitra':
      return 'القنيطرة';
    case 'Raqqa':
      return 'الرقة';
    case 'As-Suwayda':
      return 'السويداء';
    case 'Tartus':
      return 'طرطوس';
    case 'Daraa':
      return 'درعا';
    default:
      return 'Unknown Province';
  }
}
