class ColorDictionary {
  static const Map<String, String> colors = {
    '#FF0000': 'Merah',
    '#00FF00': 'Hijau',
    '#0000FF': 'Biru',
    '#FFFF00': 'Kuning',
    '#FF00FF': 'Magenta',
    '#00FFFF': 'Cyan',
    '#000000': 'Hitam',
    '#FFFFFF': 'Putih',
    '#808080': 'Abu-abu',
    '#FFA500': 'Jingga',
    '#A52A2A': 'Cokelat',
    '#800080': 'Ungu',
    '#FFC0CB': 'Merah Muda',
    '#008000': 'Hijau Tua',
    '#000080': 'Biru Dongker',
    '#FFD700': 'Emas',
    '#C0C0C0': 'Perak',
    '#4B0082': 'Indigo',
    '#EE82EE': 'Violet',
    '#40E0D0': 'Toska',
    '#800000': 'Marun',
    '#008080': 'Teal',
    '#808000': 'Zaitun',
    '#FF7F50': 'Koral',
    '#FA8072': 'Salmon',
    '#FF8C00': 'Jingga Tua',
    '#FFDAB9': 'Persik',
    '#E6E6FA': 'Lavender',
    '#DDA0DD': 'Plum',
    '#F5F5DC': 'Beige',
    '#FFF5EE': 'Kerang',
    '#F5FFFA': 'Mint',
    '#F0FFFF': 'Azure',
    '#F0F8FF': 'Biru Alice',
    '#E0FFFF': 'Cyan Muda',
    '#7FFFD4': 'Aquamarine',
    '#66CDAA': 'Medium Aquamarine',
    '#00FA9A': 'Medium Spring Green',
    '#00FF7F': 'Spring Green',
    '#98FB98': 'Pale Green',
    '#90EE90': 'Light Green',
    '#8FBC8F': 'Dark Sea Green',
    '#3CB371': 'Medium Sea Green',
    '#2E8B57': 'Sea Green',
    '#006400': 'Dark Green',
    '#9ACD32': 'Yellow Green',
    '#6B8E23': 'Olive Drab',
    '#556B2F': 'Dark Olive Green',
    '#BDB76B': 'Dark Khaki',
    '#F0E68C': 'Khaki',
    '#EEE8AA': 'Pale Goldenrod',
    '#FFB6C1': 'Light Pink',
    '#FF69B4': 'Hot Pink',
    '#FF1493': 'Deep Pink',
    '#C71585': 'Medium Violet Red',
    '#DB7093': 'Pale Violet Red',
  };

  static String getClosestColorName(int r, int g, int b) {
    double minDistance = double.infinity;
    String closestName = 'Tidak diketahui';

    for (var entry in colors.entries) {
      String hex = entry.key.replaceAll('#', '');
      int dictR = int.parse(hex.substring(0, 2), radix: 16);
      int dictG = int.parse(hex.substring(2, 4), radix: 16);
      int dictB = int.parse(hex.substring(4, 6), radix: 16);

      // Euclidean distance in RGB space
      double distance = (r - dictR) * (r - dictR) +
                        (g - dictG) * (g - dictG) +
                        (b - dictB) * (b - dictB).toDouble();

      if (distance < minDistance) {
        minDistance = distance;
        closestName = entry.value;
      }
    }

    return closestName;
  }
}
