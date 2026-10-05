import 'package:flutter/material.dart';

const kGreen = Color(0xFF4CAF50);
const kGreenSoft = Color(0xFFC8E6C9);
const kBg = Color(0xFFF8F9FB);
const kLavender = Color(0xFFE6DDF5);
const kYellow = Color(0xFFFFC107);
const kGrey = Color(0xFF757575);

String peso(num v) {
  final s = v.round().toString();
  final withCommas =
      s.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return '₱$withCommas';
}

const months = [
  'January', 'February', 'March', 'April', 'May', 'June', 'July',
  'August', 'September', 'October', 'November', 'December'
];
String longDate(DateTime d) => '${months[d.month - 1]} ${d.day}, ${d.year}';

BoxDecoration cardBox() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFEAEAEA)),
      boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))
      ],
    );

InputDecoration fieldDecoration({String? hint, Widget? suffix, Widget? prefix}) =>
    InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
      prefixIcon: prefix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
    );