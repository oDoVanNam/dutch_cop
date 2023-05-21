# frozen_string_literal: true

require_relative 'rubocop/dutch_cop/version'

require 'rubocop'

Dir[File.join(__dir__, 'rubocop', 'cop', '**', '*.rb')].sort.each { |file| require file }

module DutchCop; end
