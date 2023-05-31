# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class EnumerableMapAttribute < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Prefer `pluck(:attribute)` over `map(&:attribute)` with Enumerable'
        RESTRICT_ON_SEND = [:map].freeze

        def_node_matcher :map_attribute, <<-PATTERN
          (send ({ send lvar const array } ...) :map (block_pass (sym $_)))
        PATTERN

        def on_send(node)
          return unless (attr = map_attribute(node))

          add_offense(node, message: MSG) do |corrector|
            corrector.replace(node, "#{node.receiver.source}.pluck(:#{attr})")
          end
        end
      end
    end
  end
end
