# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class AvoidKeysOrValuesFirst < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Use %<prefer>s` instead of `%<current>s`. This reduces memory usage.'
        CORRECT_METHODS = {
          keys: 'each_key',
          values: 'each_value'
        }.freeze

        def_node_matcher :keys_values_first, <<~PATTERN
          (send (send ({send const hash lvar} ...) ${:keys :values}) :first)
        PATTERN

        def on_send(node)
          current = keys_values_first(node)
          return unless current

          correct_method = CORRECT_METHODS.fetch(current)
          msg = format(MSG, prefer: correct_method, current: current)

          add_offense(node, message: msg) do |corrector|
            replacement = "#{node.receiver.receiver.source}.#{correct_method}.first"
            corrector.replace(node, replacement)
          end
        end
      end
    end
  end
end
