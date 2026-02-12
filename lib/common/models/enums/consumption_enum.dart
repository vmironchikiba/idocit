import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

enum ConsumptionType { electricity, water, fuel }

enum ConsumptionExtendedType { electricity, water, fuel, co2 }

extension ConsumptionExtendedTypeExtension on ConsumptionExtendedType {
  static String getFixedValueString(double value, {int maxDigits = 2}) {
    final compare = 1 / math.pow(10, maxDigits);
    final fixed = double.parse(value.toStringAsFixed(maxDigits));
    return value < compare ? '>$compare' : fixed.toString();
  }

  ConsumptionType? toBasic() {
    switch (this) {
      case ConsumptionExtendedType.electricity:
        return ConsumptionType.electricity;

      case ConsumptionExtendedType.water:
        return ConsumptionType.water;

      case ConsumptionExtendedType.fuel:
        return ConsumptionType.fuel;

      default:
        return null;
    }
  }

  String getUnit({bool isShort = false}) {
    switch (this) {
      case ConsumptionExtendedType.electricity:
        return 'kWh';

      case ConsumptionExtendedType.water:
        return 'gal';

      case ConsumptionExtendedType.fuel:
        return 'therms';

      case ConsumptionExtendedType.co2:
        return isShort ? 'tonnes' : 'CO2/tonnes';
    }
  }

  String getLabel() {
    switch (this) {
      case ConsumptionExtendedType.electricity:
        return 'Electricity';

      case ConsumptionExtendedType.water:
        return 'Water';

      case ConsumptionExtendedType.fuel:
        return 'Fuel';

      case ConsumptionExtendedType.co2:
        return 'CO2';
    }
  }
}

extension ConsumptionTypeExtension on ConsumptionType {
  static ConsumptionType? fromJson(String title) {
    switch (title.toLowerCase()) {
      case 'electricity':
        return ConsumptionType.electricity;

      case 'electric':
        return ConsumptionType.electricity;

      case 'water':
        return ConsumptionType.water;

      case 'gas':
        return ConsumptionType.fuel;

      case 'fuel':
        return ConsumptionType.fuel;

      default:
        return null;
    }
  }

  static ConsumptionType? getTypeFromString(String label) {
    switch (label.toLowerCase()) {
      case 'electricity':
        return ConsumptionType.electricity;

      case 'electric':
        return ConsumptionType.electricity;

      case 'water':
        return ConsumptionType.water;

      case 'gas':
        return ConsumptionType.fuel;

      case 'fuel':
        return ConsumptionType.fuel;

      default:
        return null;
    }
  }

  String toJsonString() {
    switch (this) {
      case ConsumptionType.electricity:
        return 'electricity';

      case ConsumptionType.water:
        return 'water';

      case ConsumptionType.fuel:
        return 'fuel';
    }
  }

  ConsumptionExtendedType toExtended() {
    switch (this) {
      case ConsumptionType.electricity:
        return ConsumptionExtendedType.electricity;

      case ConsumptionType.water:
        return ConsumptionExtendedType.water;

      case ConsumptionType.fuel:
        return ConsumptionExtendedType.fuel;
    }
  }

  String getIconSrc() {
    switch (this) {
      case ConsumptionType.electricity:
        return ImageConstants.icElectricity;

      case ConsumptionType.water:
        return ImageConstants.icWater;

      case ConsumptionType.fuel:
        return ImageConstants.icFuel;
    }
  }

  Color getIconColor() {
    switch (this) {
      case ConsumptionType.electricity:
        return ColorConstants.electricity;

      case ConsumptionType.water:
        return ColorConstants.water;

      case ConsumptionType.fuel:
        return ColorConstants.fuel;
    }
  }

  Color getBGColor() {
    switch (this) {
      case ConsumptionType.electricity:
        return ColorConstants.electricityBG;

      case ConsumptionType.water:
        return ColorConstants.waterBG;

      case ConsumptionType.fuel:
        return ColorConstants.fuelBG;
    }
  }
}
