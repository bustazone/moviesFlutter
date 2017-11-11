import 'package:flutter/material.dart';
import 'package:pelis_busta/CustomCheckbox.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/FilterScreen.dart';
import 'package:pelis_busta/FiltersNavigation.dart';
import 'package:pelis_busta/GearInnerIcon.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/PressingButton.dart';
import 'package:pelis_busta/Services.dart';
import 'package:pelis_busta/Utils.dart';

class GenresFilter extends StatefulWidget {
  final String title;
  final double gearWidth;
  final AnimationController controllerIcons;

  GenresFilter(this.gearWidth, this.title, this.controllerIcons, {Key key})
      : super(key: key);

  @override
  State createState() => new GenresFilterState();
}

class GenresFilterState extends State<GenresFilter>
    with TickerProviderStateMixin {
  void updateFilterGenders(bool selected, {int codigo, String nombre}) {
    if (selected) {
      new MainFilter()
          .filter
          .generos
          .add(new Gender(id: codigo, nombre: nombre));
    } else {
      new MainFilter()
          .filter
          .generos
          .removeByValues(new Gender(id: codigo, nombre: nombre));
    }
  }

  bool checkFilterGenders({int codigo, String nombre}) {
    return new MainFilter()
        .filter
        .generos
        .hasByValues(new Gender(id: codigo, nombre: nombre));
  }

  List<GearInnerIcon> createGenderIconsList() {
    List<GearInnerIcon> listIconsp = <GearInnerIcon>[];
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/romance.png',
        'assets/imgs/romance_selected.png',
        15.0,
        128.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_ROMANCE_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_ROMANCE_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/drama.png',
        'assets/imgs/drama_selected.png',
        30.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_DRAMA_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_DRAMA_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/suspense.png',
        'assets/imgs/suspense_selected.png',
        30.0,
        184.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_SUSPENSE_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_SUSPENSE_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/horror.png',
        'assets/imgs/horror_selected.png',
        72.0,
        30.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_HORROR_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_HORROR_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/musical.png',
        'assets/imgs/musical_selected.png',
        72.0,
        225.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_MUSICAL_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_MUSICAL_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/comedy.png',
        'assets/imgs/comedy_selected.png',
        79.0,
        100.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_COMEDY_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_COMEDY_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/thriller.png',
        'assets/imgs/thriller_selected.png',
        79.0,
        156.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_THRILLER_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_THRILLER_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/scifi.png',
        'assets/imgs/scifi_selected.png',
        128.0,
        15.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_SCIFI_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_SCIFI_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/animation.png',
        'assets/imgs/animation_selected.png',
        128.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_ANIMATION_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_ANIMATION_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/noir.png',
        'assets/imgs/noir_selected.png',
        128.0,
        184.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_NOIR_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_NOIR_CODE)));
    listIconsp.add(new GearInnerIcon.mainButton(
        'assets/imgs/more.png',
        'assets/imgs/more_selected.png',
        128.0,
        240.0,
        widget.gearWidth,
        widget.controllerIcons, () {
      goToFilter(context, "MORE GENRES", FilterStates.MoreGenreFilter, () {
        setState(() {});
        widget.controllerIcons.forward();
      });
    }, false));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/kids.png',
        'assets/imgs/kids_selected.png',
        177.0,
        100.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_KIDS_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_KIDS_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/western.png',
        'assets/imgs/western_selected.png',
        177.0,
        156.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_WESTERN_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_WESTERN_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/fantastic.png',
        'assets/imgs/fantastic_selected.png',
        184.0,
        30.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_FANTASTIC_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_FANTASTIC_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/docu.png',
        'assets/imgs/docu_selected.png',
        184.0,
        225.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_DOCU_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_DOCU_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/adventure.png',
        'assets/imgs/adventure_selected.png',
        225.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_ADVENTURE_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_ADVENTURE_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/action.png',
        'assets/imgs/action_selected.png',
        225.0,
        184.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_ACTION_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_ACTION_CODE)));
    listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/imgs/belic.png',
        'assets/imgs/belic_selected.png',
        241.0,
        128.0,
        widget.gearWidth,
        widget.controllerIcons, (selected) {
      setState(() {
        updateFilterGenders(selected, codigo: Gender.GENDER_BELIC_CODE);
      });
    }, checkFilterGenders(codigo: Gender.GENDER_BELIC_CODE)));
    return listIconsp;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        //color: const Color(0xFFFF0000),
        width: widget.gearWidth,
        height: widget.gearWidth,
        child: new Stack(
          alignment: const FractionalOffset(0.5, 0.5),
          overflow: Overflow.visible,
          children: createGenderIconsList(),
        ));
  }
}
