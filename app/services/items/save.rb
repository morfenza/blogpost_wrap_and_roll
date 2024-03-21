# frozen_string_literal: true

module Items
  class Save < ApplicationService
    def initialize(item_name)
      @item_name = item_name
    end

    def call
      response = Items::Get.call(@item_name, faraday_connection)

      item = Item.new(
        name: response[:body][:name],
        cost: response[:body][:cost]
      )

      item.save!
    end

    private

    def faraday_connection
      @faraday_connection ||= PokeApi::V2::Client.new
    end
  end
end
