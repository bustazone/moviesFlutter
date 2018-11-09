import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/feats/filter/GearInnerIcon.dart';
import 'package:pelis_busta/feats/filter/GenresFilter.dart';
import 'package:pelis_busta/feats/filter/LanguagesFilter.dart';
import 'package:pelis_busta/feats/list/ListScreen.dart';
import 'package:pelis_busta/feats/filter/MainFilter.dart';
import 'package:pelis_busta/feats/filter/MoreGenreFilter.dart';
import 'package:pelis_busta/feats/filter/TextFilter.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/PressingButton.dart';
import 'package:pelis_busta/support/navigation/FiltersNavigation.dart';
import 'package:pelis_busta/support/utils/Utils.dart';
import 'package:pelis_busta/feats/filter/YearFilter.dart';
import 'package:redux/redux.dart';

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

  FilterScreen({Key key, this.title, this.currentState}) : super(key: key);

  factory FilterScreen.main({Key key, String title}) {
    return new FilterScreen(
      title: title,
      currentState: FilterStates.FilterSelector,
    );
  }

  @override
  State createState() => new FilterScreenState();
}

class FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {
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

  Widget _buildFiltersMain(animation, gearWidth, gearHeight, context, vsync) {
    List<Widget> createGenderIconsList() {
      List<Widget> listIconsp = <Widget>[];
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/cast.png',
        'assets/filterIcons/cast_selected.png',
        31.0,
        72.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "CAST", FilterStates.CastFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        !isNullOrEmpty(new MainFilter().filter.casts),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/director.png',
        'assets/filterIcons/director_selected.png',
        72.0,
        30.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "DIRECTOR", FilterStates.DirectorFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        !isNullOrEmpty(new MainFilter().filter.director),
      ));

      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/gender.png',
        'assets/filterIcons/gender_selected.png',
        79.0,
        100.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "GENRES", FilterStates.GenderFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        !isNullOrEmpty(new MainFilter().filter.generos),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/title.png',
        'assets/filterIcons/title_selected.png',
        128.0,
        15.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "TITLE", FilterStates.TitleFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        !isNullOrEmpty(new MainFilter().filter.tituloFilter),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/languages.png',
        'assets/filterIcons/languages_selected.png',
        128.0,
        72.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "LANGUAGES", FilterStates.LanguagesFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        false,
      ));
      listIconsp.add(new StoreConnector<AppState, _ViewModel>(
            converter: (store) {
              // Return a `VoidCallback`, which is a fancy name for a function
              // with no parameters. It only dispatches an Increment action.
              return _ViewModel.fromStore(store);
            },
            builder: (context, vm) {
              return new GearInnerIcon.selectableIcon(
                'assets/filterIcons/series.png',
                'assets/filterIcons/series_selected.png',
                177.0,
                100.0,
                gearWidth,
                controllerIcons,
                    (selected) {
                  setState(() {
                    new MainFilter().filter.serie = selected;
                    vm.setSeries(selected);
                  });
                },
                //new MainFilter().filter.serie,
                vm.isSeries
              );
            },
          )
      );
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/location.png',
        'assets/filterIcons/location_selected.png',
        184.0,
        30.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "LOCATION", FilterStates.LocationFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        !isNullOrEmpty(new MainFilter().filter.location),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/year.png',
        'assets/filterIcons/year_selected.png',
        225.0,
        72.0,
        gearWidth,
        controllerIcons,
            () {
          goToFilter(context, "YEAR", FilterStates.YearFilter, () {
            setState(() {});
            controllerIcons.forward();
          });
        },
        ((new MainFilter().filter.year != null) ||
            (new MainFilter().filter.minYear != null &&
                new MainFilter().filter.maxYear != null)),
      ));
      listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/filterIcons/reset.png',
        'assets/filterIcons/reset.png',
        128.0,
        240.0,
        gearWidth,
        controllerIcons,
            (selected) {
          new MainFilter().resetFilter();
          setState(() {});
        },
        false,
      ));

      return listIconsp;
    }

    return new Container(
      //color: const Color(0xFFFF0000),
        width: gearWidth,
        height: gearWidth,
        child: new Stack(
          alignment: const FractionalOffset(0.5, 0.5),
          overflow: Overflow.visible,
          children: createGenderIconsList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    gearWidth = MediaQuery
        .of(context)
        .size
        .width * 0.9;
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
          return _buildFiltersMain(
              animation, gearWidth, gearHeight, context, this);
        case FilterStates.GenderFilter:
          return new GenresFilter(gearWidth, widget.title, controllerIcons);
        case FilterStates.TitleFilter:
        case FilterStates.CastFilter:
        case FilterStates.DirectorFilter:
        case FilterStates.LocationFilter:
          return new TextFilter(gearWidth,
              title: widget.title, currentState: widget.currentState);
        case FilterStates.MoreGenreFilter:
          return new MoreGenresFilter(gearWidth, widget.title);
        case FilterStates.LanguagesFilter:
          return new LanguagesFilter(gearWidth, widget.title);
        case FilterStates.YearFilter:
          return new YearFilter(gearWidth, currentState: widget.currentState);
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
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new ListScreen(new MainFilter().filter, true);
                }));
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
            var filmFilter = new FilmFilter();
            filmFilter.randomFilm = true;
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new ListScreen(filmFilter, false);
                }));
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
    controller.dispose();
    controllerIcons.dispose();
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

class _ViewModel {
  final Function(bool) setSeries;
  final bool isSeries;

  _ViewModel({
    @required this.setSeries,
    @required this.isSeries,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      setSeries: (isSeries) {
        store.dispatch(SetSeriesAction(isSeries));
      },
      isSeries: store.state.filter.series,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              isSeries == other.isSeries;

  @override
  int get hashCode => isSeries.hashCode;
}