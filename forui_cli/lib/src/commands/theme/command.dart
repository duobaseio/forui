import 'package:forui_cli/src/commands/theme/create_command.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';

class ThemeCommand extends ForuiCommand {
  @override
  final name = 'theme';

  @override
  final aliases = ['t'];

  @override
  final description = 'Manage your Forui themes.';

  ThemeCommand(Configuration configuration) {
    addSubcommand(ThemeCreateCommand(configuration));
  }
}
