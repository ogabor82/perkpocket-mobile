import 'package:flutter/material.dart';

class RewardCardModel {
  final String id;
  final String merchantName;
  final String programName;
  final int currentPoints;
  final int targetPoints;
  final Color backgroundColor;
  final IconData icon;

  const RewardCardModel({
    required this.id,
    required this.merchantName,
    required this.programName,
    required this.currentPoints,
    required this.targetPoints,
    required this.backgroundColor,
    required this.icon,
  });
}