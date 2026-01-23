/// App constants
class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Storage keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String authTokenKey = 'authToken';

  // Animation durations
  static const int fastAnimationDuration = 150;
  static const int normalAnimationDuration = 300;
  static const int slowAnimationDuration = 500;

  // Glassmorphism
  static const double glassBlurSigma = 10.0;
  static const double glassOpacity = 0.1;
  static const double glassBorderOpacity = 0.2;
  static const double glassBorderRadius = 12.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;

  // Font sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 32.0;

  // Icons
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  static const double iconSizeXXL = 80.0;

  // Touch targets
  static const double minTouchTarget = 48.0;

  // Grid
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.85;
  static const double gridSpacing = 16.0;

  // Card
  static const double cardElevation = 2.0;
  static const double cardPadding = 16.0;

  // Button
  static const double buttonHeight = 56.0;
  static const double buttonBorderRadius = 12.0;

  // Dialog
  static const double dialogBorderRadius = 16.0;
  static const double dialogPadding = 24.0;

  // Bottom sheet
  static const double bottomSheetBorderRadius = 20.0;
  static const double bottomSheetPadding = 24.0;

  // Loading
  static const int simulatedFetchDelay = 1000; // ms
  static const int simulatedUpdateDelay = 500; // ms

  // Text truncation
  static const int maxTitleLength = 20;
}
