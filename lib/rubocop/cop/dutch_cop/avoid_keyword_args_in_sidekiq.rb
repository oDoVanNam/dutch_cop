# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class AvoidKeywordArgsInSidekiq < RuboCop::Cop::Base
        MSG = 'Avoid keyword arguments in Sidekiq jobs. Use positional arguments instead. Refer to https://github.com/sidekiq/sidekiq/issues/2372'

        def on_def(node)
          return unless node.method_name == :perform

          node.arguments.each do |arg|
            next unless arg.type == :kwoptarg || arg.type == :kwarg

            add_offense(arg)
          end
        end
      end
    end
  end
end
