// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final otpField = FOtpField(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Verification Code'),
  description: const Text('Enter the 6-digit code.'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  forceErrorText: null,
  onSaved: null,
  onReset: null,
  validator: null,
  autovalidateMode: .disabled,
  formFieldKey: null,
  // {@endcategory}
  // {@category "Field"}
  builder: FOtpField.defaultBuilder,
  magnifierConfiguration: null,
  groupId: EditableText,
  keyboardType: null,
  textInputAction: .done,
  textCapitalization: .none,
  textDirection: null,
  autofocus: false,
  focusNode: null,
  readOnly: false,
  onTapAlwaysCalled: false,
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  onTap: () {},
  onTapOutside: (event) {},
  inputFormatters: FOtpField.defaultInputFormatters,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectionControls: null,
  dragStartBehavior: .start,
  mouseCursor: null,
  autofillHints: const [AutofillHints.oneTimeCode],
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  contextMenuBuilder: null,
  canRequestFocus: true,
  undoController: null,
  statesController: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .context(),
  enabled: true,
  // {@endcategory}
);

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the controller internally. Allows configuring children and initial value.
final FOtpFieldControl managedInternal = .managed(
  children: const [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
  initial: null,
  onChange: (value) {},
);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external `FOtpController` to control the OTP field's state.
final FOtpFieldControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FOtpController(),
  onChange: (value) {},
);
