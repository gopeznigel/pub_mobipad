import 'package:built_value/built_value.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/core/dtos.dart';

part 'state.g.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  factory HomeState([void Function(HomeStateBuilder b) updates]) = _$HomeState;

  factory HomeState.initial() => _$HomeState._(
        noteCategory: NoteCategoryEnum.active,
        selectionMode: SelectionModeEnum.none,
        selectedNotes: [],
        notes: [],
        isLoading: false,
        isSearching: false,
        searchKeyword: '',
      );

  HomeState._();

  NoteCategoryEnum get noteCategory;
  SelectionModeEnum get selectionMode;
  List<NoteDto> get selectedNotes;
  List<NoteDto> get notes;
  bool get isSearching;
  bool get isLoading;
  String get searchKeyword;
  ActionException? get exception;
}
