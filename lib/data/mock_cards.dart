import 'package:flutter/material.dart';
import '../models/reward_card_model.dart';
import '../theme/app_colors.dart';

const mockCards = [
  RewardCardModel(
    id: '1',
    merchantName: '3Beans Coffee',
    programName: 'Coffee Card',
    currentPoints: 3,
    targetPoints: 7,
    backgroundColor: AppColors.cardGold,
    icon: Icons.local_cafe_rounded,
  ),
  RewardCardModel(
    id: '2',
    merchantName: 'Bloom Bakery',
    programName: 'Bread & Pastry Club',
    currentPoints: 5,
    targetPoints: 8,
    backgroundColor: AppColors.cardRed,
    icon: Icons.bakery_dining_rounded,
  ),
  RewardCardModel(
    id: '3',
    merchantName: 'FitZone Gym',
    programName: 'Workout Rewards',
    currentPoints: 2,
    targetPoints: 5,
    backgroundColor: AppColors.cardBlue,
    icon: Icons.fitness_center_rounded,
  ),
];