# frozen_string_literal: true

module Rubocop
  module Cop
    module DutchCop
      class ProjectHash < RuboCop::Cop::Base
        include RuboCop::Cop::RangeHelp
        extend RuboCop::Cop::AutoCorrector

        MSG = 'Missing project hash comment.'

        def on_new_investigation
          return if processed_source.tokens.empty? || hash_code_exists?

          missing_offense(processed_source)
        end

        private

        def hash_code
          "# #{cop_config['HashPrefix']} : #{cop_config['HashCode']}"
        end

        def missing_offense(processed_source)
          range = source_range(processed_source.buffer, 0, 0)

          add_offense(range) { |corrector| insert_comment(corrector) }
        end

        def insert_comment(corrector)
          corrector.insert_before(processed_source.buffer.source_range, preceding_comment)
        end

        def preceding_comment
          "#{hash_code}\n"
        end

        def hash_code_exists?
          leading_comment_lines.any? { |line| line.eql?(hash_code) }
        end

        def leading_comment_lines
          first_non_comment_token = processed_source.tokens.find { |token| !token.comment? }

          return processed_source.lines[0...first_non_comment_token.line - 1] if first_non_comment_token

          processed_source.lines
        end
      end
    end
  end
end
