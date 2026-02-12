import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/cupertino.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/sizes.dart';

class FootprintPinnedRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Color? backgroundColor;
  final double marginMultiplier;
  final bool isOnTopPosition;

  const FootprintPinnedRefreshIndicator({
    super.key,
    required this.onRefresh,
    this.backgroundColor,
    this.marginMultiplier = 1.0,
    this.isOnTopPosition = false,
  });

  final _kActivityIndicatorRadius = 14.0;
  final _kActivityIndicatorMargin = 16.0;

  Widget _buildIndicatorForRefreshState(RefreshIndicatorMode refreshState, double radius, double percentageComplete) {
    switch (refreshState) {
      case RefreshIndicatorMode.drag:
        {
          const scaleCurve = Interval(0.1, 0.5, curve: Curves.linear);
          const opacityCurve = Interval(0.2, 0.6, curve: Curves.linear);

          return Transform.scale(
            scale: scaleCurve.transform(percentageComplete),
            child: Opacity(
              opacity: opacityCurve.transform(percentageComplete),
              child: const IdocItLoadingIndicator(size: 30.0),
            ),
          );
        }

      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        {
          return const IdocItLoadingIndicator(size: 30.0);
        }

      case RefreshIndicatorMode.done:
        {
          const scaleCurve = Interval(0.3, 0.7, curve: Curves.linear);
          const opacityCurve = Interval(0.3, 0.7, curve: Curves.linear);

          return Transform.scale(
            scale: scaleCurve.transform(percentageComplete),
            child: Opacity(
              opacity: opacityCurve.transform(percentageComplete),
              child: const IdocItLoadingIndicator(size: 30.0),
            ),
          );
        }

      case RefreshIndicatorMode.inactive:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPositionPadding = isOnTopPosition
        ? MediaQuery.of(context).viewPadding.top + SizeConstants.defaultPadding
        : 0.0;

    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) {
        final percentageComplete = clampDouble(pulledExtent / refreshTriggerPullDistance, 0.0, 1.0);
        final topPosition = _kActivityIndicatorMargin * marginMultiplier + topPositionPadding;

        return Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(decoration: BoxDecoration(color: backgroundColor)),
              ),
              Positioned(
                top: topPosition * percentageComplete,
                left: 0.0,
                right: 0.0,
                child: _buildIndicatorForRefreshState(refreshState, _kActivityIndicatorRadius, percentageComplete),
              ),
            ],
          ),
        );
      },
    );
  }
}
