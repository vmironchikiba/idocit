import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/utils/gif_builder.dart';

class ImageConstants {
  static void precacheAssets(BuildContext context) {
    precacheImage(Image.asset(ImageConstants.icSplashLogo).image, context);
    precacheImage(Image.asset(ImageConstants.icLoading).image, context);
    precacheImage(Image.asset(ImageConstants.icUSFlag).image, context);

    GifBuilder.precacheGIF(Image.asset(ImageConstants.igSplashLogoGIF).image, frameRate: 30);
    GifBuilder.precacheGIF(Image.asset(ImageConstants.igProgressGIF).image, frameRate: 30);

    const svgLoaders = <SvgAssetLoader>[
      /// Sliders
      SvgAssetLoader(ImageConstants.icWelcomeSlider1),
      SvgAssetLoader(ImageConstants.icWelcomeSlider2),
      SvgAssetLoader(ImageConstants.icWelcomeSlider3),
      SvgAssetLoader(ImageConstants.icHowToUseSlider1),
      SvgAssetLoader(ImageConstants.icHowToUseSlider2),
      SvgAssetLoader(ImageConstants.icHowToUseSlider3),

      /// Text field
      SvgAssetLoader(ImageConstants.icTextFieldClose),
      SvgAssetLoader(ImageConstants.icTextFieldEye),
      SvgAssetLoader(ImageConstants.icTextFieldOk),

      /// Service
      SvgAssetLoader(ImageConstants.icRefresh),
      SvgAssetLoader(ImageConstants.icArrowBlack),
      SvgAssetLoader(ImageConstants.icArrowGrey),
      SvgAssetLoader(ImageConstants.icClose),
      SvgAssetLoader(ImageConstants.icCloseWhite),
      SvgAssetLoader(ImageConstants.icCloseBrown),

      /// Bottom navigation bar
      SvgAssetLoader(ImageConstants.icNavigationHome),
      SvgAssetLoader(ImageConstants.icNavigationEcoKit),
      SvgAssetLoader(ImageConstants.icNavigationProfile),
    ];

    for (final loader in svgLoaders) {
      svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  /// Service icons
  static const icArrowBlack = 'assets/icons/ic_arrow_black.svg';
  static const icArrowGrey = 'assets/icons/ic_arrow_grey.svg';
  static const icClose = 'assets/icons/ic_close.svg';
  static const icCloseWhite = 'assets/icons/ic_close_white.svg';
  static const icCloseBrown = 'assets/icons/ic_close_brown.svg';
  static const icDropdownGreen = 'assets/icons/ic_dropdown_green.svg';
  static const icDropdownHome = 'assets/icons/ic_dropdown_home.svg';
  static const icLoading = 'assets/icons/ic_loading.png';
  static const icSuccess = 'assets/icons/ic_success.svg';
  static const icMore = 'assets/icons/ic_more.svg';
  static const icCheckBox = 'assets/icons/ic_check_box.svg';
  static const icFavorite = 'assets/icons/ic_favorite.svg';
  static const icRefresh = 'assets/icons/ic_refresh.svg';
  static const icAttention = 'assets/icons/ic_attention.svg';
  static const icTextFieldClose = 'assets/icons/ic_textfield_close.svg';
  static const icTextFieldEye = 'assets/icons/ic_textfield_eye.svg';
  static const icTextFieldOk = 'assets/icons/ic_textfield_ok.svg';
  static const icSearch = 'assets/icons/ic_search.svg';

  /// Bottom navigation bar icons
  static const icNavigationHome = 'assets/icons/ic_navigation_home.svg';
  static const icNavigationEcoKit = 'assets/icons/ic_navigation_eco_kit.svg';
  static const icNavigationProfile = 'assets/icons/ic_navigation_profile.svg';

  /// Custom LF icons
  static const icJCoin = 'assets/icons/joules/ic_joul.svg';
  static const icMoneyCoin = 'assets/icons/joules/ic_money.svg';
  static const icElectricity = 'assets/icons/joules/ic_electricity.svg';
  static const icWater = 'assets/icons/joules/ic_water.svg';
  static const icFuel = 'assets/icons/joules/ic_fuel.svg';
  static const icCO2 = 'assets/icons/joules/ic_co2.svg';

  static const icTree = 'assets/icons/custom/ic_tree.png';
  static const icQuote = 'assets/icons/custom/ic_quote.svg';
  static const icWorld = 'assets/icons/custom/ic_world.svg';
  static const icBestTime = 'assets/icons/custom/ic_best_time.svg';
  static const icCounterCircle = 'assets/icons/custom/ic_counter_circle.png';

  /// Companies
  static const icElectricityConEd = 'assets/icons/companies/ic_electricity_ConEd.svg';
  static const icElectricityPSEG = 'assets/icons/companies/ic_electricity_PSEG.svg';
  static const icWaterNYC = 'assets/icons/companies/ic_water_NYC.svg';
  static const icWaterNationalGrid = 'assets/icons/companies/ic_water_national_grid.png';
  static const icPersonalProvider = 'assets/icons/companies/ic_personal_provider.svg';

  /// Flags
  static const icUSFlag = 'assets/icons/flags/ic_us_flag.png';

  /// Profile
  static const icHowToUse = 'assets/icons/profile/ic_how_to_use.svg';
  static const icRoadmap = 'assets/icons/profile/ic_roadmap.svg';
  static const icRules = 'assets/icons/profile/ic_rules.svg';
  static const icDashboard = 'assets/icons/profile/ic_dashboard.svg';
  static const icHelpCenter = 'assets/icons/profile/ic_help_center.svg';
  static const icProfile = 'assets/icons/profile/ic_profile.svg';
  static const icRate = 'assets/icons/profile/ic_rate.svg';
  static const icUnits = 'assets/icons/profile/ic_units.svg';
  static const icInfo = 'assets/icons/ic_info.svg';

  /// Profile - other
  static const icProfileEdit = 'assets/icons/profile/ic_profile_edit.svg';
  static const icProfileEditPass = 'assets/icons/profile/ic_profile_edit_pass.svg';
  static const icProfileLogout = 'assets/icons/profile/ic_profile_logout.svg';
  static const icProfileUnits = 'assets/icons/profile/ic_profile_units.svg';
  static const icProfileTemperature = 'assets/icons/profile/ic_profile_temperature.svg';

  /// Multi houses
  static const icHome = 'assets/icons/multi_houses/ic_home.svg';
  static const icHomeType = 'assets/icons/multi_houses/ic_home_type.svg';
  static const icSquare = 'assets/icons/multi_houses/ic_square.svg';
  static const icZipcode = 'assets/icons/multi_houses/ic_zipcode.svg';
  static const icBuildingOwner = 'assets/icons/multi_houses/ic_building_owner.svg';
  static const icBuildingOwnerGray = 'assets/icons/multi_houses/ic_building_owner_gray.svg';
  static const icBuildingOwnerGreen = 'assets/icons/multi_houses/ic_building_owner_green.svg';
  static const icHomeowner = 'assets/icons/multi_houses/ic_homeowner.svg';
  static const icHomeownerGray = 'assets/icons/multi_houses/ic_homeowner_gray.svg';
  static const icHomeownerGreen = 'assets/icons/multi_houses/ic_homeowner_green.svg';
  static const icTenant = 'assets/icons/multi_houses/ic_tenant.svg';
  static const icTenantGray = 'assets/icons/multi_houses/ic_tenant_gray.svg';
  static const icTenantGreen = 'assets/icons/multi_houses/ic_tenant_green.svg';
  static const icHomeUnknown = 'assets/icons/multi_houses/ic_home_unknown.svg';

  /// Errors
  static const icOnErrorElectricity = 'assets/icons/errors/ic_on_error_electricity.svg';
  static const icOnErrorWater = 'assets/icons/errors/ic_on_error_water.svg';
  static const icOnErrorFuel = 'assets/icons/errors/ic_on_error_fuel.svg';
  static const icOnErrorConsumptions = 'assets/icons/errors/ic_on_error_consumptions.svg';
  static const icOnErrorConed = 'assets/icons/errors/ic_on_error_coned.svg';
  static const icOnErrorLBS = 'assets/icons/errors/ic_on_error_lbs.svg';

  /// Congratulations & Link providers
  static const icCompaniesList = 'assets/icons/registration/ic_companies.svg';
  static const icGraphic = 'assets/icons/registration/ic_graphic.svg';
  static const icJoulToCash = 'assets/icons/registration/ic_joul_to_cash.svg';
  static const icJoulToCashAndDiscount = 'assets/icons/registration/ic_joul_to_cash_and_discount.svg';
  static const icJoulToCoin = 'assets/icons/registration/ic_joul_to_coin.svg';

  /// Consumption statuses
  static const icStatusElectricityEfficient = 'assets/icons/status/ic_status_electricity_efficient.svg';
  static const icStatusElectricityAverage = 'assets/icons/status/ic_status_electricity_average.svg';
  static const icStatusElectricityInefficient = 'assets/icons/status/ic_status_electricity_inefficient.svg';
  static const icStatusWaterEfficient = 'assets/icons/status/ic_status_water_efficient.svg';
  static const icStatusWaterAverage = 'assets/icons/status/ic_status_water_average.svg';
  static const icStatusWaterInefficient = 'assets/icons/status/ic_status_water_inefficient.svg';
  static const icStatusFuelEfficient = 'assets/icons/status/ic_status_fuel_efficient.svg';
  static const icStatusFuelAverage = 'assets/icons/status/ic_status_fuel_average.svg';
  static const icStatusFuelInefficient = 'assets/icons/status/ic_status_fuel_inefficient.svg';
  static const icStatusElectricityDisabled = 'assets/icons/status/ic_status_electricity_disabled.svg';
  static const icStatusWaterDisabled = 'assets/icons/status/ic_status_water_disabled.svg';
  static const icStatusFuelDisabled = 'assets/icons/status/ic_status_fuel_disabled.svg';

  /// Referral code
  static const icReferralInviteAndEarn = 'assets/icons/referral_code/im_invite_and_earn.svg';
  static const icReferralSuccess = 'assets/icons/referral_code/im_referral_success.svg';

  /// How to use & welcome screen examples slider
  static const icHowToUseSlider1 = 'assets/icons/how_to_use/ic_how_to_use_slider_1.svg';
  static const icHowToUseSlider2 = 'assets/icons/how_to_use/ic_how_to_use_slider_2.svg';
  static const icHowToUseSlider3 = 'assets/icons/how_to_use/ic_how_to_use_slider_3.svg';
  static const icWelcomeSlider1 = 'assets/icons/how_to_use/ic_welcome_slider_1.svg';
  static const icWelcomeSlider2 = 'assets/icons/how_to_use/ic_welcome_slider_2.svg';
  static const icWelcomeSlider3 = 'assets/icons/how_to_use/ic_welcome_slider_3.svg';

  /// Help center
  static const icNotFound = 'assets/icons/help_center/ic_no_results.svg';
  static const icQuestionSent = 'assets/icons/help_center/ic_question_sent.svg';

  /// LBS logo
  static const icLBS = 'assets/icons/logo/ic_lbs_logo.svg';
  static const icSplashLogo = 'assets/icons/logo/ic_splash_logo.png';
  static const icLBSSmallLabel = 'assets/icons/logo/ic_lbs_small_label.svg';
  static const icIdocItLogo = 'assets/icons/logo/ic_livefootprint_logo.svg';

  /// Custom LF GIF-s
  static const igSplashLogoGIF = 'assets/gifs/ig_splash_logo.gif';
  static const igProgressGIF = 'assets/gifs/ig_progress.gif';
  static const icSplashLogoSvg = 'assets/icons/logo/ic_splash_logo.svg';
  static const igIdocIt = 'assets/icons/idocit.svg';

  static const userChatAvatarSvg = 'assets/icons/user_chat_avatar.svg';
  static const addSvg = 'assets/icons/add.svg';
}
