# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class DestroyAll < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Prefer `delete_all` over `destroy_all`. Because `destroy_all` will load all records into memory and then destroy them one by one.'
        RESTRICT_ON_SEND = [:destroy_all].freeze

        def_node_matcher :destroy_all?, <<-PATTERN
          (send ({ send const lvar } ...) :destroy_all)
        PATTERN

        def on_send(node)
          add_offense(node, message: MSG) do |corrector|
            corrector.replace(node, "#{node.receiver.source}.delete_all")
          end
        end
      end
    end
  end
end
