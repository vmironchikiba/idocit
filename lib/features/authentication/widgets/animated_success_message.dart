import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';

class AnimatedSuccessMessage extends StatefulWidget {
  final String contentText;
  final Widget? contentWidget;
  final VoidCallback? callback;
  final bool isShowing;

  const AnimatedSuccessMessage({
    Key? key,
    this.contentText = 'Sample',
    this.contentWidget,
    this.callback,
    this.isShowing = true,
  }) : super(key: key);

  @override
  State<AnimatedSuccessMessage> createState() => _AnimatedSuccessMessageState();
}

class _AnimatedSuccessMessageState extends State<AnimatedSuccessMessage> {
  bool _isContentShowed = true;

  @override
  void initState() {
    super.initState();
    _isContentShowed = widget.isShowing;
  }

  @override
  void didUpdateWidget(covariant AnimatedSuccessMessage oldWidget) {
    if (oldWidget.isShowing != widget.isShowing && widget.isShowing == true) {
      setState(() {
        _isContentShowed = true;
      });
    }

    if (oldWidget.isShowing != widget.isShowing && widget.isShowing == false) {
      Future.delayed(const Duration(milliseconds: 1000)).then((_) {
        if (mounted) {
          setState(() {
            _isContentShowed = false;
          });
        }
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final contentWidget =
        widget.contentWidget ??
        IdocItText(
          text: widget.contentText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 16.0 / 14.0),
        );

    return GestureDetector(
      onTap: widget.callback,
      child: AnimatedOpacity(
        duration: StyleConstants.defaultAnimationDuration,
        opacity: widget.isShowing ? 1.0 : 0.0,
        child: AnimatedContainer(
          duration: StyleConstants.defaultAnimationDuration,
          padding: EdgeInsets.symmetric(vertical: widget.isShowing ? 16.0 : 0.0, horizontal: 12.0),
          margin: EdgeInsets.only(top: widget.isShowing ? 8.0 : 0.0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: ColorConstants.black450,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: AnimatedAlign(
            duration: StyleConstants.defaultAnimationDuration,
            alignment: Alignment.centerLeft,
            heightFactor: widget.isShowing ? 1.0 : 0.0,
            child: _isContentShowed
                ? Row(
                    children: [
                      SizedBox.square(
                        dimension: SizeConstants.defaultIconSize,
                        child: SvgPicture.asset(ImageConstants.icSuccess),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(child: contentWidget),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
