# frozen_string_literal: true

module Pokemons
  class Save < ApplicationService
    def initialize(pokemon_name)
      @pokemon_name = pokemon_name
    end

    def call
      response = Pokemons::Get.call(@pokemon_name, faraday_connection)

      pokemon = Pokemon.new(
        name: response[:body][:name],
        height: response[:body][:height],
        weight: response[:body][:weight]
      )

      pokemon.save!
    end

    private

    def faraday_connection
      @faraday_connection ||= PokeApi::V2::Client.new
    end
  end
end
