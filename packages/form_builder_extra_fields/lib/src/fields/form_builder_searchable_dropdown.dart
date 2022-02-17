import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selecting value(s) from a searchable list
class FormBuilderSearchableDropdown<T> extends FormBuilderField<T> {
  final bool shouldRequestFocus;

  ///show/hide the search box
  final bool showSearchBox;

  ///true if the filter on items is applied onlie (via API)
  final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool showClearButton;

  ///offline items list
  final List<T>? items;

  ///selected item
  final T? selectedItem;

  ///selected items
  final List<T> selectedItems;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? onFind;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  ///to customize selected item
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;

  ///the title for dialog/menu/bottomSheet
  final Color? popupBackgroundColor;

  ///custom widget for the popup title
  final Widget? popupTitle;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///MENU / DIALOG/ BOTTOM_SHEET
  final Mode mode;

  ///the max height for dialog/bottomSheet/Menu
  final double? maxHeight;

  ///the max width for the dialog
  final double? dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItems;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// style on which to base the label
  final TextStyle? dropdownSearchBaseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  ///custom layout for empty results
  final EmptyBuilder? emptyBuilder;

  ///custom layout for loading items
  final LoadingBuilder? loadingBuilder;

  ///custom layout for error
  final ErrorBuilder? errorBuilder;

  ///custom shape for the popup
  final ShapeBorder? popupShape;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  ///custom dropdown clear button icon widget
  final Widget? clearButton;

  ///custom clear button widget builder
  final IconButtonBuilder? clearButtonBuilder;

  ///custom splash radius for the clear button
  ///If null, default splash radius of [icon_button] is used.
  final double? clearButtonSplashRadius;

  ///custom dropdown icon button widget
  final Widget? dropDownButton;

  ///custom dropdown button widget builder
  final IconButtonBuilder? dropdownButtonBuilder;

  ///custom splash radius for the dropdown button
  ///If null, default splash radius of [icon_button] is used.
  final double? dropdownButtonSplashRadius;

  ///whether to manage the clear and dropdown icons via InputDecoration suffixIcon
  final bool showAsSuffixIcons;

  ///If true, the dropdownBuilder will continue the uses of material behavior
  ///This will be useful if you want to handle a custom UI only if the item !=null
  final bool dropdownBuilderSupportsNullItem;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final DropdownSearchPopupItemEnabled<T>? popupItemDisabled;

  ///set a custom color for the popup barrier
  final Color? popupBarrierColor;

  ///called when popup is dismissed
  final VoidCallback? onPopupDismissed;

  /// callback executed before applying value change
  ///delay before searching, change it to Duration(milliseconds: 0)
  ///if you do not use online search
  final Duration? searchDelay;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///show or hide favorites items
  final bool showFavoriteItems;

  ///to customize favorites chips
  final FavoriteItemsBuilder<T>? favoriteItemBuilder;

  ///favorites items list
  final FavoriteItems<T>? favoriteItems;

  ///favorite items alignment
  final MainAxisAlignment? favoriteItemsAlignment;

  ///set properties of popup safe area
  final PopupSafeAreaProps popupSafeArea;

  /// object that passes all props to search field
  final TextFieldProps? searchFieldProps;

  /// scrollbar properties
  final ScrollbarProps? scrollbarProps;

  /// whether modal can be dismissed by tapping the modal barrier
  final bool popupBarrierDismissible;

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

  /// elevation for popup items
  final double popupElevation;

  /// function to override position calculation
  final PositionCallback? positionCallback;

  final dropdown_search.SelectionListViewProps selectionListViewProps;

  /// Creates field for selecting value(s) from a searchable list
  FormBuilderSearchableDropdown({
    Key? key,
    //From Super
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
    this.autoValidateMode,
    this.clearButton,
    this.clearButtonBuilder,
    this.clearButtonSplashRadius,
    this.compareFn,
    this.dialogMaxWidth,
    this.dropdownBuilder,
    this.dropdownBuilderMultiSelection,
    this.dropdownBuilderSupportsNullItem = false,
    this.dropDownButton,
    this.dropdownButtonBuilder,
    this.dropdownButtonSplashRadius,
    this.dropdownSearchBaseStyle,
    this.dropdownSearchDecoration,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.emptyBuilder,
    this.errorBuilder,
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.filterFn,
    this.isFilteredOnline = false,
    this.isMultiSelectionMode = false,
    this.itemAsString,
    this.items,
    this.loadingBuilder,
    this.maxHeight,
    this.mode = dropdown_search.Mode.MENU,
    this.onBeforeChange,
    this.onBeforeChangeMultiSelection,
    this.onChangedMultiSelection,
    this.onFind,
    this.onPopupDismissed,
    this.onSavedMultiSelection,
    this.popupBackgroundColor,
    this.popupBarrierColor,
    this.popupBarrierDismissible = true,
    this.popupElevation = 0,
    this.popupItemBuilder,
    this.popupItemDisabled,
    this.popupOnItemAdded,
    this.popupOnItemRemoved,
    this.popupSafeArea = const PopupSafeAreaProps(),
    this.popupSelectionWidget,
    this.popupShape,
    this.popupTitle,
    this.popupValidationMultiSelectionWidget,
    this.positionCallback,
    this.scrollbarProps,
    this.searchDelay,
    this.searchFieldProps,
    this.selectedItem,
    this.selectedItems = const [],
    this.selectionListViewProps = const SelectionListViewProps(),
    this.shouldRequestFocus = false,
    this.showAsSuffixIcons = false,
    this.showClearButton = false,
    this.showFavoriteItems = false,
    this.showSearchBox = true,
    this.showSelectedItems = false,
  }) : super(
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
            final state = field as _FormBuilderSearchableDropdownState<T>;
            return dropdown_search.DropdownSearch<T>(
              // Hack to rebuild when didChange is called
              key: UniqueKey(),
              items: items,
              maxHeight: maxHeight,
              onFind: onFind,
              onChanged: (value) {
                if (shouldRequestFocus) {
                  state.requestFocus();
                }
                state.didChange(value);
              },
              selectionListViewProps: selectionListViewProps,
              showSearchBox: showSearchBox,
              enabled: state.enabled,
              autoValidateMode: autovalidateMode,
              clearButton: clearButton,
              compareFn: compareFn,
              dialogMaxWidth: dialogMaxWidth,
              dropdownBuilder: dropdownBuilder,
              dropdownBuilderSupportsNullItem: dropdownBuilderSupportsNullItem,
              dropDownButton: dropDownButton,
              dropdownSearchDecoration: state.decoration,
              emptyBuilder: emptyBuilder,
              errorBuilder: errorBuilder,
              filterFn: filterFn,
              isFilteredOnline: isFilteredOnline,
              itemAsString: itemAsString,
              loadingBuilder: loadingBuilder,
              popupBackgroundColor: popupBackgroundColor,
              mode: mode,
              popupBarrierColor: popupBarrierColor,
              popupItemBuilder: popupItemBuilder,
              popupItemDisabled: popupItemDisabled,
              popupShape: popupShape,
              popupTitle: popupTitle,
              selectedItem: state.value,
              showClearButton: showClearButton,
              clearButtonBuilder: clearButtonBuilder,
              dropdownButtonBuilder: dropdownButtonBuilder,
              favoriteItemBuilder: favoriteItemBuilder,
              favoriteItems: favoriteItems,
              onBeforeChange: onBeforeChange,
              favoriteItemsAlignment: favoriteItemsAlignment,
              onPopupDismissed: onPopupDismissed,
              searchDelay: searchDelay,
              showAsSuffixIcons: showAsSuffixIcons,
              showFavoriteItems: showFavoriteItems,
              clearButtonSplashRadius: clearButtonSplashRadius,
              dropdownButtonSplashRadius: dropdownButtonSplashRadius,
              dropdownSearchBaseStyle: dropdownSearchBaseStyle,
              dropdownSearchTextAlign: dropdownSearchTextAlign,
              dropdownSearchTextAlignVertical: dropdownSearchTextAlignVertical,
              // onSaved: onSaved,
              popupBarrierDismissible: popupBarrierDismissible,
              popupElevation: popupElevation,
              popupSafeArea: popupSafeArea,
              scrollbarProps: scrollbarProps,
              searchFieldProps: searchFieldProps,
              showSelectedItems: showSelectedItems,
              positionCallback: positionCallback,
            );
          },
        );

  @override
  _FormBuilderSearchableDropdownState<T> createState() =>
      _FormBuilderSearchableDropdownState<T>();
}

class _FormBuilderSearchableDropdownState<T>
    extends FormBuilderFieldState<FormBuilderSearchableDropdown<T>, T> {}
