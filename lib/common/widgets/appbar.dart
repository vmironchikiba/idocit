import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/common/widgets/wrappers/opacity_wrapper.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

enum IdocItAppBarType { black, grey }

class FootprintAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? heroTag;
  final String? title;
  final Widget? titleContent;
  final Widget? leading;
  final Widget? actions;
  @override
  final Size preferredSize;
  final double horizontalPadding;
  final IdocItAppBarType type;
  final bool withBackButton;
  final bool withShadow;
  final bool isBlocked;
  final VoidCallback? backButtonCallback;

  const FootprintAppBar({
    Key? key,
    this.heroTag,
    this.title,
    this.titleContent,
    this.leading,
    this.actions,
    this.preferredSize = const Size.fromHeight(SizeConstants.defaultAppBarSize),
    this.horizontalPadding = 24.0,
    this.type = IdocItAppBarType.black,
    this.withBackButton = true,
    this.withShadow = true,
    this.isBlocked = false,
    this.backButtonCallback,
  }) : super(key: key);

  Widget? _buildTitleWidget(BuildContext context) {
    if (titleContent != null) {
      return titleContent!;
    }

    if (title != null) {
      return IdocItText(
        text: title!,
        style: Theme.of(context).appBarTheme.titleTextStyle,
        maxLines: 2,
        textAlign: TextAlign.center,
        isVerticalCentered: false,
      );
    }

    return null;
  }

  Widget? _buildLeadingWidget(BuildContext context) {
    if (leading != null) {
      return leading!;
    }

    if (withBackButton) {
      return GestureDetector(
        onTap: backButtonCallback ?? () => Navigator.of(context).pop(),
        child: SizedBox.square(dimension: 40.0, child: SvgPicture.asset(_getAppBarIconSrc(type))),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appBarBackgroundColor = _getAppBarBackgroundColor(type, context);
    final titleWidget = _buildTitleWidget(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: IdocItOpacityWrapper(
        isOpaque: isBlocked,
        child: MorphingAppBar(
          heroTag: heroTag ?? 'MorphingAppBar',
          backgroundColor: appBarBackgroundColor,
          shadowColor: Theme.of(context).appBarTheme.shadowColor,
          elevation: withShadow ? Theme.of(context).appBarTheme.elevation : 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: preferredSize.height,
          titleSpacing: 0.0,
          title: Row(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: horizontalPadding),
                  child: _buildLeadingWidget(context) ?? const SizedBox(),
                ),
              ),
              if (titleWidget != null)
                Flexible(
                  flex: 4,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstants.defaultPadding),
                      child: titleWidget,
                    ),
                  ),
                ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: horizontalPadding),
                  child: actions ?? const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Only works with fixed flexibleContent size
class IdocItSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? heroTag;
  final String? title;
  final Widget? titleContent;
  final Widget? leading;
  final Widget? actions;
  final FlexibleSpaceBar? flexibleContent;
  @override
  final Size preferredSize;
  final double horizontalPadding;
  final double flexibleSize;
  final IdocItAppBarType type;
  final bool withBackButton;
  final bool withShadow;
  final bool isBlocked;
  final ShapeBorder? shapeBorder;
  final VoidCallback? backButtonCallback;

  const IdocItSliverAppBar({
    Key? key,
    this.heroTag,
    this.title,
    this.titleContent,
    this.leading,
    this.actions,
    this.flexibleContent,
    this.preferredSize = const Size.fromHeight(SizeConstants.defaultAppBarSize),
    this.horizontalPadding = 24.0,
    this.flexibleSize = 0.0,
    this.type = IdocItAppBarType.black,
    this.withBackButton = true,
    this.withShadow = true,
    this.isBlocked = false,
    this.shapeBorder,
    this.backButtonCallback,
  }) : super(key: key);

  Widget? _buildTitleWidget(BuildContext context) {
    if (titleContent != null) {
      return titleContent!;
    }

    if (title != null) {
      return IdocItText(
        text: title!,
        style: Theme.of(context).appBarTheme.titleTextStyle,
        maxLines: 2,
        textAlign: TextAlign.center,
        isVerticalCentered: false,
      );
    }

    return null;
  }

  Widget? _buildLeadingWidget(BuildContext context) {
    if (leading != null) {
      return leading!;
    }

    if (withBackButton) {
      return GestureDetector(
        onTap: backButtonCallback ?? () => Navigator.of(context).pop(),
        child: SizedBox.square(dimension: 40.0, child: SvgPicture.asset(_getAppBarIconSrc(type))),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appBarBackgroundColor = _getAppBarBackgroundColor(type, context);
    final titleWidget = _buildTitleWidget(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: MorphingSliverAppBar(
        heroTag: heroTag ?? 'MorphingAppBar',
        backgroundColor: appBarBackgroundColor,
        shadowColor: Theme.of(context).appBarTheme.shadowColor,
        elevation: withShadow ? Theme.of(context).appBarTheme.elevation : 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        pinned: true,
        titleSpacing: 0.0,
        shape: shapeBorder,
        toolbarHeight: preferredSize.height,
        collapsedHeight: preferredSize.height,
        expandedHeight: preferredSize.height + flexibleSize,
        title: Container(
          height: preferredSize.height,
          color: appBarBackgroundColor,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: horizontalPadding),
                  child: _buildLeadingWidget(context) ?? const SizedBox(),
                ),
              ),
              if (titleWidget != null)
                Flexible(
                  flex: 4,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstants.defaultPadding),
                      child: titleWidget,
                    ),
                  ),
                ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: horizontalPadding),
                  child: actions ?? const SizedBox(),
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: flexibleContent,
      ),
    );
  }
}

Color? _getAppBarBackgroundColor(IdocItAppBarType type, BuildContext context) {
  switch (type) {
    case IdocItAppBarType.black:
      return Theme.of(context).appBarTheme.backgroundColor;

    case IdocItAppBarType.grey:
      return ColorConstants.black450;
  }
}

String _getAppBarIconSrc(IdocItAppBarType type) {
  switch (type) {
    case IdocItAppBarType.black:
      return ImageConstants.icArrowGrey;

    case IdocItAppBarType.grey:
      return ImageConstants.icArrowBlack;
  }
}
