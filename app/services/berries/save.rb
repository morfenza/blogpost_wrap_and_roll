# frozen_string_literal: true

module Berries
  class Save < ApplicationService
    def initialize(berry_name)
      @berry_name = berry_name
    end

    def call
      response = Pokemons::Get.call(@berry_name, faraday_connection)

      berry = Berry.new(
        name: response[:body][:name],
        size: response[:body][:size],
        smoothness: response[:body][:smoothness]
      )

      berry.save!
    end

    private

    def faraday_connection
      @faraday_connection ||= PokeApi::V2::Client.new
    end
  end
end
