# rubocop:disable Naming/FileName
# frozen_string_literal: true

require_relative "activerecord-ejection_seat/version"

require "active_support/lazy_load_hooks"

ActiveSupport.on_load(:active_record) do
  require "activerecord-ejection_seat/ejectable"
end
# rubocop:enable Naming/FileName
