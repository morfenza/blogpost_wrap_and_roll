# frozen_string_literal: true

require 'faraday'

module PokeApi
  module V2
    class Client
      POKE_API_BASE_URL = 'https://pokeapi.co/api/v2/'

      def get_pokemon(pokemon_name)
        request(
          http_method: :get,
          endpoint: "pokemon/#{pokemon_name}"
        )
      end

      private

      def client
        @client ||= begin
          options = {
            open_timeout: 10,
            read_timeout: 10
          }
          Faraday.new(url: POKE_API_BASE_URL, **options) do |config|
            config.request :json
            config.response :json, parser_options: { symbolize_names: true }
            config.response :raise_error
            config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
          end
        end
      end

      def request(http_method:, endpoint:, body: {})
        response = client.public_send(http_method, endpoint, body)
        {
          status: response.status,
          body: response.body
        }
      end
    end
  end
end
