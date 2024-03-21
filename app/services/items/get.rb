# frozen_string_literal: true

module Items
  class Get < ApplicationService
    def initialize(item_name, connection)
      @item_name = item_name
      @connection = connection
    end

    def call
      @connection.get_item(@item_name)
    end
  end
end
