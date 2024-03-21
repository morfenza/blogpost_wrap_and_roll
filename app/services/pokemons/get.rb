# frozen_string_literal: true

module Pokemons
  class Get < ApplicationService
    def initialize(pokemon_name, connection)
      @pokemon_name = pokemon_name
      @connection = connection
    end

    def call
      @connection.get_pokemon(@pokemon_name)
    end
  end
end
