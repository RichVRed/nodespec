require 'timeout'
require_relative 'verbose_output'
require_relative 'run_options'

module NodeSpec
  module CommandExecution
    class CommandExecutionError < StandardError; end
    include VerboseOutput

    def execute_within_timeout(command, timeout = NodeSpec::RunOptions.command_timeout, &block)
      verbose_puts "\nExecuting command:\n#{command}"
      command_success = Timeout::timeout(timeout, &block)
      raise CommandExecutionError.new 'The command execution failed. Enable verbosity to check the output.' unless command_success
    end
  end
end