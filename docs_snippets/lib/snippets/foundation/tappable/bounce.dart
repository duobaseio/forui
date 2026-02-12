// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

const defaultMotion =
    // {@snippet constructor}
    // Default animation.
    FTappableMotion(bounceTween: FTappableMotion.defaultBounceTween);
// {@endsnippet}

// {@snippet constructor}

const noMotion =
    // {@snippet constructor}
    // No animation.
    FTappableMotion.none;
// {@endsnippet}

// {@snippet constructor}

final customMotion =
    // {@snippet constructor}
    // Custom tween.
    FTappableMotion(bounceTween: Tween(begin: 1.0, end: 0.97));
// {@endsnippet}
