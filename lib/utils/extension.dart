import 'package:intl/intl.dart';

extension RupiahFormatter on int {
  String toRupiah() {
    NumberFormat intToRupiah = NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp',
    );
    return intToRupiah.format(this);
  }
}
