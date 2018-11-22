import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/FilterScreenContainer.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/main.dart';
import 'package:pelis_busta/feats/filter/components/GearInnerIcon.dart';
import 'package:pelis_busta/feats/filter/components/GenresFilter.dart';
import 'package:pelis_busta/feats/filter/components/LanguagesFilter.dart';
import 'package:pelis_busta/feats/filter/components/MainFilter.dart';
import 'package:pelis_busta/feats/filter/components/MoreGenreFilter.dart';
import 'package:pelis_busta/feats/filter/components/TextFilter.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/PressingButton.dart';
import 'package:pelis_busta/feats/filter/components/YearFilter.dart';

enum FilterStates {
  FilterSelector,
  GenderFilter,
  MoreGenreFilter,
  TitleFilter,
  CastFilter,
  LocationFilter,
  DirectorFilter,
  LanguagesFilter,
  YearFilter,
  None
}

class FilterScreen extends StatefulWidget {
  final String title;
  final FilterStates currentState;
  final ViewModel vm;

  FilterScreen(this.currentState, this.vm, {Key key, this.title})
      : super(key: key);

  @override
  State createState() => new FilterScreenState();
}

class FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin, RouteAware {
  List<GearInnerIcon> listIcons = <GearInnerIcon>[];
  var iconsStack;
  var screenWidth;
  var screenHeight;
  var gearWidth;
  var gearHeight;

  Animation<double> animation;
  Animation<double> animationIcons;
  AnimationController controller;
  AnimationController controllerIcons;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush");
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPopNext");
    controllerIcons.forward();
  }

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Curve cur = new Cubic(.55, 1.02, .81, 1.07);
    final Animation curve = new CurvedAnimation(parent: controller, curve: cur);
    animation = new Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controllerIcons.forward();
        }
      });
    if (widget.currentState == FilterStates.FilterSelector) {
      controller.forward();
    }

    controllerIcons = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    if (widget.currentState != FilterStates.FilterSelector) {
      controllerIcons.forward();
    }
//    Curve curIcons = new Cubic(.87, .75, .88, 1.6);
//    final Animation curveIcons =
//    new CurvedAnimation(parent: controllerIcons, curve: curIcons);
//    animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    gearWidth = MediaQuery.of(context).size.width * 0.9;
    gearHeight =
        DesignConstants.gearHeight * (gearWidth / DesignConstants.gearWidth);

    Widget getReturnButton() {
      if (widget.currentState != FilterStates.FilterSelector) {
        return new Positioned(
          child: new PressingButton(
              'assets/imgs/return.png',
              'assets/imgs/return_selected.png',
              30.0 * (gearWidth / DesignConstants.gearWidth),
              30.0 * (gearWidth / DesignConstants.gearWidth), () {
            Navigator.of(context).pop();
          }),
          left: (gearWidth / 2.0) -
              15.0 * (gearWidth / DesignConstants.gearWidth),
          top: (gearWidth / 2.0) -
              15.0 * (gearWidth / DesignConstants.gearWidth),
        );
      } else {
        return new Container(
          width: 0.0,
          height: 0.0,
        );
      }
    }

    Widget getMainButtons() {
      switch (widget.currentState) {
        case FilterStates.FilterSelector:
          return new MainFilter(
              animation, controllerIcons, gearWidth, gearHeight, widget.vm);
        case FilterStates.GenderFilter:
          return new GenresFilter(gearWidth, widget.title, controllerIcons,
              widget.vm.genres, widget.vm.setGenres);
        case FilterStates.TitleFilter:
          return new TextFilter(gearWidth, widget.title, widget.vm.title,
              widget.vm.setTitle, widget.vm.resetTitle);
        case FilterStates.CastFilter:
          return new TextFilter(gearWidth, widget.title, widget.vm.cast,
              widget.vm.setCast, widget.vm.resetCast);
        case FilterStates.DirectorFilter:
          return new TextFilter(gearWidth, widget.title, widget.vm.director,
              widget.vm.setDirector, widget.vm.resetDirector);
        case FilterStates.LocationFilter:
          return new TextFilter(gearWidth, widget.title, widget.vm.location,
              widget.vm.setLocation, widget.vm.resetLocation);
        case FilterStates.MoreGenreFilter:
          return new MoreGenresFilter(
              gearWidth, widget.title, widget.vm.genres, widget.vm.setGenres);
        case FilterStates.LanguagesFilter:
          return new LanguagesFilter(
              gearWidth,
              widget.title,
              widget.vm.languages,
              widget.vm.setLanguages,
              widget.vm.resetLanguages,
              widget.vm.subtitles,
              widget.vm.setSubtitles,
              widget.vm.resetSubtitles);
        case FilterStates.YearFilter:
          return new YearFilter(
              gearWidth,
              widget.vm.year,
              widget.vm.minYear,
              widget.vm.maxYear,
              widget.vm.setYear,
              widget.vm.setMinYear,
              widget.vm.setMaxYear,
              widget.vm.resetYears);
        default:
          return new Container(
            width: 0.0,
            height: 0.0,
          );
      }
    }

    Widget getMainGear() {
      return new Stack(alignment: const FractionalOffset(0.0, 0.5), children: [
        new Positioned(
          child: new PressingButton(
              'assets/imgs/search.png',
              'assets/imgs/search_selected.png',
              124.0 * (gearWidth / DesignConstants.gearWidth),
              //75.0 * (gearWidth / DesignConstants.gearWidth)
              null, () {
            Navigator.of(context).pushNamed(ListRouteName);
          }),
          left: screenWidth / 2.0,
          top: (screenHeight / 2.0) +
              (gearWidth / 2.0) -
              (35 * (gearWidth / DesignConstants.gearWidth)),
        ),
        new Positioned(
          child: new PressingButton(
              'assets/imgs/random.png',
              'assets/imgs/random_selected.png',
              124.0 * (gearWidth / DesignConstants.gearWidth),
              //75.0 * (gearWidth / DesignConstants.gearWidth)
              null, () {
            Navigator.of(context).pushNamed(RandomFilmRouteName);
          }),
          left: (screenWidth / 2.0) -
              (124.0 * (gearWidth / DesignConstants.gearWidth)),
          top: (screenHeight / 2.0) +
              (gearWidth / 2.0) -
              (35 * (gearWidth / DesignConstants.gearWidth)),
        ),
        new Positioned(
          child: new Stack(
            alignment: const FractionalOffset(0.0, 0.5),
            children: [
              new Transform.rotate(
                angle: pi * animation.value,
                origin: new Offset(0.0, 0.0),
                child: _buildGear(animation, gearWidth),
              ),
              getReturnButton(),
              getMainButtons(),
            ],
          ),
          left: screenWidth * 0.05,
          top: (screenHeight - gearWidth) / 2.0,
        ),
      ]);
    }

    return new Scaffold(
        body: new Container(
      color: const Color(0xFFEAEAEA),
      child: new Center(
        child: getMainGear(),
      ),
    ));
  }

  @override
  dispose() {
    routeObserver.unsubscribe(this);
    controller.dispose();
    super.dispose();
  }
}

Widget _buildGear(animation, gearWidth) {
  return new Image.asset(
    'assets/imgs/gear.png',
    width: gearWidth,
    height: gearWidth,
  );
}
