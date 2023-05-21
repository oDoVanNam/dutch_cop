# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class AvoidUsingFindByWithoutSpecifyAttribute < RuboCop::Cop::Base
        MSG = 'Avoid using find_by without specify attribute. Use find_by(attribute: value) instead.'

        def on_send(node)
          return unless node.method_name == :find_by

          node.arguments.each do |arg|
            add_offense(arg) if arg.type != :hash
          end
        end
      end
    end
  end
end
