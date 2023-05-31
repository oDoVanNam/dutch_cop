# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class Tally < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Preferred `tally` over `group_by(&:itself).transform_values(&:count)`'
        RESTRICT_ON_SEND = [:group_by, :transform_values].freeze

        def_node_matcher :group_by_transform_values_count?, <<-PATTERN
          (send (send ({ send const array lvar } ...) :group_by (block_pass (sym :itself))) :transform_values (block_pass (sym :count)))
        PATTERN

        def on_send(node)
          return unless group_by_transform_values_count?(node)

          add_offense(node, message: MSG) do |corrector|
            corrector.replace(node, "#{node.receiver.receiver.source}.tally")
          end
        end
      end
    end
  end
end
