// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeState extends HomeState {
  @override
  final NoteCategoryEnum noteCategory;
  @override
  final SelectionModeEnum selectionMode;
  @override
  final List<NoteDto> selectedNotes;
  @override
  final List<NoteDto> notes;
  @override
  final bool isSearching;
  @override
  final bool isLoading;
  @override
  final String searchKeyword;
  @override
  final ActionException? exception;

  factory _$HomeState([void Function(HomeStateBuilder)? updates]) =>
      (new HomeStateBuilder()..update(updates))._build();

  _$HomeState._(
      {required this.noteCategory,
      required this.selectionMode,
      required this.selectedNotes,
      required this.notes,
      required this.isSearching,
      required this.isLoading,
      required this.searchKeyword,
      this.exception})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        noteCategory, r'HomeState', 'noteCategory');
    BuiltValueNullFieldError.checkNotNull(
        selectionMode, r'HomeState', 'selectionMode');
    BuiltValueNullFieldError.checkNotNull(
        selectedNotes, r'HomeState', 'selectedNotes');
    BuiltValueNullFieldError.checkNotNull(notes, r'HomeState', 'notes');
    BuiltValueNullFieldError.checkNotNull(
        isSearching, r'HomeState', 'isSearching');
    BuiltValueNullFieldError.checkNotNull(isLoading, r'HomeState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(
        searchKeyword, r'HomeState', 'searchKeyword');
  }

  @override
  HomeState rebuild(void Function(HomeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeStateBuilder toBuilder() => new HomeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeState &&
        noteCategory == other.noteCategory &&
        selectionMode == other.selectionMode &&
        selectedNotes == other.selectedNotes &&
        notes == other.notes &&
        isSearching == other.isSearching &&
        isLoading == other.isLoading &&
        searchKeyword == other.searchKeyword &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, noteCategory.hashCode),
                                selectionMode.hashCode),
                            selectedNotes.hashCode),
                        notes.hashCode),
                    isSearching.hashCode),
                isLoading.hashCode),
            searchKeyword.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeState')
          ..add('noteCategory', noteCategory)
          ..add('selectionMode', selectionMode)
          ..add('selectedNotes', selectedNotes)
          ..add('notes', notes)
          ..add('isSearching', isSearching)
          ..add('isLoading', isLoading)
          ..add('searchKeyword', searchKeyword)
          ..add('exception', exception))
        .toString();
  }
}

class HomeStateBuilder implements Builder<HomeState, HomeStateBuilder> {
  _$HomeState? _$v;

  NoteCategoryEnum? _noteCategory;
  NoteCategoryEnum? get noteCategory => _$this._noteCategory;
  set noteCategory(NoteCategoryEnum? noteCategory) =>
      _$this._noteCategory = noteCategory;

  SelectionModeEnum? _selectionMode;
  SelectionModeEnum? get selectionMode => _$this._selectionMode;
  set selectionMode(SelectionModeEnum? selectionMode) =>
      _$this._selectionMode = selectionMode;

  List<NoteDto>? _selectedNotes;
  List<NoteDto>? get selectedNotes => _$this._selectedNotes;
  set selectedNotes(List<NoteDto>? selectedNotes) =>
      _$this._selectedNotes = selectedNotes;

  List<NoteDto>? _notes;
  List<NoteDto>? get notes => _$this._notes;
  set notes(List<NoteDto>? notes) => _$this._notes = notes;

  bool? _isSearching;
  bool? get isSearching => _$this._isSearching;
  set isSearching(bool? isSearching) => _$this._isSearching = isSearching;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _searchKeyword;
  String? get searchKeyword => _$this._searchKeyword;
  set searchKeyword(String? searchKeyword) =>
      _$this._searchKeyword = searchKeyword;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  HomeStateBuilder();

  HomeStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noteCategory = $v.noteCategory;
      _selectionMode = $v.selectionMode;
      _selectedNotes = $v.selectedNotes;
      _notes = $v.notes;
      _isSearching = $v.isSearching;
      _isLoading = $v.isLoading;
      _searchKeyword = $v.searchKeyword;
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeState;
  }

  @override
  void update(void Function(HomeStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeState build() => _build();

  _$HomeState _build() {
    final _$result = _$v ??
        new _$HomeState._(
            noteCategory: BuiltValueNullFieldError.checkNotNull(
                noteCategory, r'HomeState', 'noteCategory'),
            selectionMode: BuiltValueNullFieldError.checkNotNull(
                selectionMode, r'HomeState', 'selectionMode'),
            selectedNotes: BuiltValueNullFieldError.checkNotNull(
                selectedNotes, r'HomeState', 'selectedNotes'),
            notes: BuiltValueNullFieldError.checkNotNull(
                notes, r'HomeState', 'notes'),
            isSearching: BuiltValueNullFieldError.checkNotNull(
                isSearching, r'HomeState', 'isSearching'),
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'HomeState', 'isLoading'),
            searchKeyword: BuiltValueNullFieldError.checkNotNull(
                searchKeyword, r'HomeState', 'searchKeyword'),
            exception: exception);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
