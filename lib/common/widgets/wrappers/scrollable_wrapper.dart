import 'package:flutter/material.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/appbar.dart';
import 'package:idocit/common/widgets/indicators/pinned_refresh_indicator.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';

enum IdocItScrollableWrapperType { expanded, slim, dialog }

class ScrollableWrapperNotification extends Notification {
  @override
  void dispatch(BuildContext? target) {
    LoggerService.logDebug('ScrollableWrapperNotification -> dispatch()');
    super.dispatch(target);
  }
}

class ScrollableWrapper extends StatefulWidget {
  final ScrollController? controller;
  final Widget child;
  final IdocItSliverAppBar? sliverAppBar;
  final FootprintPinnedRefreshIndicator? sliverRefreshIndicator;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final IdocItScrollableWrapperType type;
  final bool isScrollBlocked;
  final bool isAlwaysScrollable;

  const ScrollableWrapper({
    Key? key,
    this.controller,
    required this.child,
    this.sliverAppBar,
    this.sliverRefreshIndicator,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: SizeConstants.defaultPadding),
    this.type = IdocItScrollableWrapperType.expanded,
    this.isScrollBlocked = false,
    this.isAlwaysScrollable = false,
  }) : super(key: key);

  @override
  State<ScrollableWrapper> createState() => _ScrollableWrapperState();
}

class _ScrollableWrapperState extends State<ScrollableWrapper> with WidgetsBindingObserver {
  final _scrollerKey = GlobalKey();
  final _widgetKey = GlobalKey();
  double _widgetSize = 0.0;

  late final ScrollController _scrollController;
  bool _isScrollEnabled = false;
  bool _isScrollToRefreshEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleWidgetSize());
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback());
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      _postFrameCallback();
    });
  }

  @override
  void didUpdateWidget(covariant ScrollableWrapper oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleWidgetSize(withCallback: true);
    });

    super.didUpdateWidget(oldWidget);
  }

  void _handleWidgetSize({bool withCallback = false}) {
    if (widget.isAlwaysScrollable) return;
    if (!mounted) return;

    final widgetContext = _widgetKey.currentContext;
    if (widgetContext == null) {
      return;
    }

    final oldSize = _widgetSize;
    final newSize = widgetContext.size!.height;

    if (mounted && oldSize != newSize) {
      setState(() {
        _widgetSize = newSize;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleWidgetSize(withCallback: withCallback);
        if (withCallback) {
          _postFrameCallback();
        }
      });
    }
  }

  void _postFrameCallback() {
    if (widget.isAlwaysScrollable) return;
    if (!mounted) return;

    final scrollerContext = _scrollerKey.currentContext;
    final widgetContext = _widgetKey.currentContext;
    final sliverAppBarHeight = widget.sliverAppBar?.flexibleSize ?? 0.0;

    if (scrollerContext == null || widgetContext == null) {
      return;
    }

    final isNotEnoughSpace = widgetContext.size!.height + sliverAppBarHeight > scrollerContext.size!.height;
    if (mounted && _isScrollEnabled != isNotEnoughSpace) {
      setState(() {
        _isScrollEnabled = isNotEnoughSpace;
      });
    }
  }

  bool _onListenAnimatedSizeHandler(_) {
    if (mounted) {
      _postFrameCallback();
    }
    return true;
  }

  void _onListenScrollToRefreshHandler(_) {
    if (!mounted) return;

    final scrollZoneOffset = MediaQuery.of(context).size.height * 0.1;
    if (_scrollController.offset <= scrollZoneOffset && _isScrollToRefreshEnabled != true) {
      setState(() {
        _isScrollToRefreshEnabled = true;
      });
      return;
    }

    if (_scrollController.offset > scrollZoneOffset && _isScrollToRefreshEnabled != false) {
      setState(() {
        _isScrollToRefreshEnabled = false;
      });
      return;
    }
  }

  Widget _buildChildWidget() {
    return Flex(
      key: _widgetKey,
      direction: widget.direction,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: <Widget>[
        SizedBox.square(dimension: widget.padding.top),
        Flexible(child: widget.child),
        SizedBox.square(dimension: widget.padding.bottom),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isScrollEnabled = (!widget.isScrollBlocked && _isScrollEnabled) || widget.isAlwaysScrollable;
    final isScrollListenerActive = isScrollEnabled && widget.sliverRefreshIndicator != null;
    final isRefreshIndicatorEnabled = widget.sliverRefreshIndicator != null && _isScrollToRefreshEnabled;

    if (widget.type == IdocItScrollableWrapperType.dialog) {
      return SingleChildScrollView(
        key: _scrollerKey,
        controller: _scrollController,
        scrollDirection: widget.direction,
        physics: isScrollEnabled ? StyleConstants.defaultPhysics : const NeverScrollableScrollPhysics(),
        child: _buildChildWidget(),
      );
    }

    return NotificationListener<ScrollableWrapperNotification>(
      onNotification: _onListenAnimatedSizeHandler,
      child: Listener(
        onPointerDown: isScrollListenerActive ? _onListenScrollToRefreshHandler : null,
        child: CustomScrollView(
          key: _scrollerKey,
          controller: _scrollController,
          scrollDirection: widget.direction,
          physics: isScrollEnabled ? StyleConstants.defaultPhysics : const NeverScrollableScrollPhysics(),
          slivers: [
            if (isRefreshIndicatorEnabled && widget.sliverRefreshIndicator?.isOnTopPosition == true)
              widget.sliverRefreshIndicator!,
            if (widget.sliverAppBar != null) widget.sliverAppBar!,
            if (isRefreshIndicatorEnabled && widget.sliverRefreshIndicator?.isOnTopPosition == false)
              widget.sliverRefreshIndicator!,
            widget.type == IdocItScrollableWrapperType.expanded
                ? SliverFillRemaining(hasScrollBody: false, child: _buildChildWidget())
                : SliverToBoxAdapter(child: _buildChildWidget()),
          ],
        ),
      ),
    );
  }
}
