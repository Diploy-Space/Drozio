import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Wraps content in a responsive container.
/// On mobile devices (width <= 480px), it occupies the entire screen.
/// On desktop or wide browsers, it frames the screen cleanly with an optimal mobile width
/// and backdrop shadow, simulating a premium flagship device frame.
class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxMobileWidth;
  final Color backgroundColor;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.maxMobileWidth = AppConstants.maxMobileContentWidth,
    this.backgroundColor = const Color(0xFFF1F5F9),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= maxMobileWidth) {
          return child;
        }

        return Container(
          color: backgroundColor,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxMobileWidth,
                maxHeight: constraints.maxHeight,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRect(
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
