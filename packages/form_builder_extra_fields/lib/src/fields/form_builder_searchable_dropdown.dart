import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selecting value(s) from a searchable list
class FormBuilderSearchableDropdown<T> extends FormBuilderField<T> {
  final bool shouldRequestFocus;

  ///true if the filter on items is applied onlie (via API)
  // final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool showClearButton;

  ///offline items list
  final List<T> items;

  ///selected item
  final T? selectedItem;

  ///selected items
  final List<T> selectedItems;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// style on which to base the label
  // final TextStyle? dropdownSearchBaseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///define whatever we are in multi selection mode or single selection mode
  final bool isMultiSelectionMode;

  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? popupOnItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? popupOnItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? popupSelectionWidget;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T?>?
      popupValidationMultiSelectionWidget;

  ///widget to add custom widget like addAll/removeAll on popup multi selection mode
  final ValidationMultiSelectionBuilder<T>? popupCustomMultiSelectionWidget;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? asyncItems;

  final PopupProps<T> popupProps;

  ///custom dropdown clear button icon properties
  final IconButtonProps? clearButtonProps;

  /// style on which to base the label
  final TextStyle? dropdownSearchTextStyle;

  ///custom dropdown icon button properties
  final IconButtonProps? dropdownButtonProps;

  /// Creates field for selecting value(s) from a searchable list
  FormBuilderSearchableDropdown({
    Key? key,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    InputDecoration decoration = const InputDecoration(),
    required String name,
    T? initialValue,
    ValueChanged<T?>? onChanged,
    ValueTransformer<T?>? valueTransformer,
    VoidCallback? onReset,
    this.asyncItems,
    this.autoValidateMode,
    this.compareFn,
    this.dropdownBuilder,
    this.dropdownSearchDecoration,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.filterFn,
    // this.isFilteredOnline = false,
    this.itemAsString,
    this.items = const [],
    this.onBeforeChange,
    this.popupOnItemAdded,
    this.popupOnItemRemoved,
    this.popupSelectionWidget,
    this.selectedItem,
    this.selectedItems = const [],
    this.shouldRequestFocus = false,
    this.showClearButton = false,
    this.popupProps = const PopupProps.menu(),
    this.clearButtonProps,
    this.dropdownSearchTextStyle,
    this.dropdownButtonProps,
  })  : assert(T == String || compareFn != null),
        isMultiSelectionMode = false,
        dropdownBuilderMultiSelection = null,
        onBeforeChangeMultiSelection = null,
        onSavedMultiSelection = null,
        onChangedMultiSelection = null,
        popupValidationMultiSelectionWidget = null,
        popupCustomMultiSelectionWidget = null,
        super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<T?> field) {
            final state = field as FormBuilderSearchableDropdownState<T>;
            return dropdown_search.DropdownSearch<T>(
              // Hack to rebuild when didChange is called
              key: UniqueKey(),
              asyncItems: asyncItems,
              clearButtonProps: clearButtonProps,
              compareFn: compareFn,
              enabled: state.enabled,
              dropdownBuilder: dropdownBuilder,
              dropdownButtonProps: dropdownButtonProps,
              dropdownSearchDecoration: state.decoration,
              dropdownSearchTextAlign: dropdownSearchTextAlign,
              dropdownSearchTextAlignVertical: dropdownSearchTextAlignVertical,
              dropdownSearchTextStyle: dropdownSearchTextStyle,
              filterFn: filterFn,
              // isFilteredOnline: isFilteredOnline,
              items: items,
              itemAsString: itemAsString,
              onBeforeChange: onBeforeChange,
              onChanged: (value) {
                if (shouldRequestFocus) {
                  state.requestFocus();
                }
                state.didChange(value);
              },
              popupProps: popupProps,
              selectedItem: state.value,
              showClearButton: showClearButton,
            );
          },
        );

  @override
  FormBuilderSearchableDropdownState<T> createState() =>
      FormBuilderSearchableDropdownState<T>();
}

class FormBuilderSearchableDropdownState<T>
    extends FormBuilderFieldState<FormBuilderSearchableDropdown<T>, T> {}
