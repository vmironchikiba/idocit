import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_data.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/appbar.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/common/widgets/dialogs/warning_dialog.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/common/widgets/wrappers/opacity_wrapper.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';
import 'package:idocit/injection_container.dart';
import 'package:provider/provider.dart';

class InAppFailureBackground extends StatefulWidget {
  const InAppFailureBackground({Key? key}) : super(key: key);

  @override
  State<InAppFailureBackground> createState() => _InAppFailureBackgroundState();
}

class _InAppFailureBackgroundState extends State<InAppFailureBackground> {
  final _inAppFailureProvider = locator<InAppFailureProvider>();
  bool _isRequestInProgress = false;

  @override
  void initState() {
    super.initState();
    _inAppFailureProvider.addListener(_onProviderListener);
  }

  @override
  void dispose() {
    _inAppFailureProvider.removeListener(_onProviderListener);
    super.dispose();
  }

  Future<void> _onProviderListener() async {
    if (!_inAppFailureProvider.isShowingDialog || _isRequestInProgress) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
    });
    _inAppFailureProvider.primaryType!.getTitle();
    await idocitShowDialog<bool?>(
      IdocItWarningDialog(
        label: _inAppFailureProvider.primaryType!.getTitle(),
        description: _inAppFailureProvider.primaryType!.getDescription(),
        iconSrc: _inAppFailureProvider.iconSrc,
        buttonText: _inAppFailureProvider.primaryType!.getButtonTitle(),
        buttonCallback: _onTryAgainHandler,
      ),
    );

    if (_inAppFailureProvider.primaryOptions?.onGoBack != null) {
      _inAppFailureProvider.primaryOptions!.onGoBack!();
    }

    _inAppFailureProvider.clear();
    setState(() {
      _isRequestInProgress = false;
    });
  }

  Future<void> _onTryAgainHandler() async {
    if (_isRequestInProgress || !_inAppFailureProvider.isHaveFailures) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
    });

    await _inAppFailureProvider.processAllFailures();
    if (_inAppFailureProvider.primaryOptions?.onGoNext != null) {
      await _inAppFailureProvider.primaryOptions!.onGoNext!();
    }

    setState(() {
      _isRequestInProgress = false;
    });
  }

  void _onGoBackHandler() {
    if (_inAppFailureProvider.primaryOptions?.onGoBack != null) {
      _inAppFailureProvider.primaryOptions!.onGoBack!();
    }

    _inAppFailureProvider.clear();
  }

  Future<bool> _onWillPopCallback() async {
    if (_isRequestInProgress) {
      return false;
    }

    _onGoBackHandler();
    return true;
  }

  Widget _buildFailureWidget(InAppFailureProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IdocItOpacityWrapper(
          isOpaque: _isRequestInProgress,
          child: Column(
            children: [
              SizedBox(height: 112.0, child: SvgPicture.asset(provider.iconSrc)),
              const SizedBox(height: 12.0),
              IdocItText(
                text: provider.primaryType?.getTitle() ?? 'Unknown',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorConstants.white500),
              ),
              if (provider.primaryType != null) ...[
                const SizedBox(height: 6.0),
                IdocItText(
                  text: provider.primaryType?.getDescription() ?? 'Unknown',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: ColorConstants.greyBlue450.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        IdocItTextButton(
          contentText: provider.primaryType?.getButtonTitle() ?? 'Unknown',
          height: 40.0,
          labelPadding: const EdgeInsets.symmetric(
            vertical: SizeConstants.defaultPadding * 0.5,
            horizontal: SizeConstants.defaultPadding * 2.0,
          ),
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            height: 16.0 / 14.0,
            color: ColorConstants.white500,
          ),
          isSlim: true,
          withProgress: _isRequestInProgress,
          callback: _onTryAgainHandler,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final inAppFailureProvider = context.watch<InAppFailureProvider>();
    return WillPopScope(
      onWillPop: _onWillPopCallback,
      child: AnimatedSwitcher(
        duration: StyleConstants.defaultAnimationDuration,
        child: inAppFailureProvider.isShowing && inAppFailureProvider.primaryType != InAppFailureType.linkProviders
            ? DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (!inAppFailureProvider.isImportant)
                      SafeArea(child: IdocItAppBar(backButtonCallback: _onGoBackHandler)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 60.0,
                        horizontal: SizeConstants.isSmallDevice() ? 60.0 : 80.0,
                      ),
                      child: _buildFailureWidget(inAppFailureProvider),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
