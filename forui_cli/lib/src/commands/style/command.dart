import 'package:forui_cli/src/commands/style/create_command.dart';
import 'package:forui_cli/src/commands/style/ls_command.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';

class StyleCommand extends ForuiCommand {
  @override
  final name = 'style';

  @override
  final aliases = ['st'];

  @override
  final description = 'Manage your Forui widget styles.';

  StyleCommand(Configuration configuration) {
    addSubcommand(StyleCreateCommand(configuration));
    addSubcommand(StyleLsCommand());
  }
}
