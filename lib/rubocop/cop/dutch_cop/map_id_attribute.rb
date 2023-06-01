# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class MapIdAttribute < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Prefer `pluck(:%<attribute>s)` over `map(&:%<attribute>s)` with primary key or foreign key.'
        RESTRICT_ON_SEND = [:map].freeze

        def_node_matcher :map_attribute, <<-PATTERN
          (send ({ send lvar const array } ...) :map (block_pass (sym $_)))
        PATTERN

        def on_send(node)
          attr = map_attribute(node)
          return if attr.nil? || !attr.to_s.match?('id')

          add_offense(node, message: format(MSG, attribute: attr)) do |corrector|
            corrector.replace(node, "#{node.receiver.source}.pluck(:#{attr})")
          end
        end
      end
    end
  end
end
