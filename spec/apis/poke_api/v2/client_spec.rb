# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeApi::V2::Client do
  subject(:wrapper) { described_class.new }

  describe '#get_pokemon' do
    context 'when the pokemon name is valid' do
      let(:pokemon_name) { 'sprigatito' }

      let(:hash_keys) { %i[name height weight] }

      let(:get_pokemon) do
        VCR.use_cassette('successful_get_pokemon') do
          wrapper.get_pokemon(pokemon_name)
        end
      end

      it 'returns an 200 status code' do
        result = get_pokemon

        expect(result[:status]).to eq 200
      end

      it 'returns a body with pokemon name, height and weight' do
        result = get_pokemon

        expect(result[:body]).to include(*hash_keys)
      end
    end

    context 'when the pokemon name is valid with webmock' do
      before do
        VCR.turn_off!

        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/sprigatito')
          .to_return(
            status: 200,
            body: {
              name: 'sprigatito',
              height: 25,
              weight: 5
            }.to_json
          )
      end

      let(:pokemon_name) { 'sprigatito' }

      let(:hash_keys) { %w[name height weight] }

      let(:get_pokemon) do
        wrapper.get_pokemon(pokemon_name)
      end

      it 'returns an 200 status code' do
        result = get_pokemon

        expect(result[:status]).to eq 200
      end

      it 'returns a body with pokemon name, height and weight' do
        result = get_pokemon

        expect(result[:body]).to include(*hash_keys)
      end
    end

    context 'when the pokemon name is invalid' do
      let(:pokemon_name) { 'antedeguemon' }

      let(:get_pokemon) do
        VCR.use_cassette('failed_get_pokemon') do
          wrapper.get_pokemon(pokemon_name)
        end
      end

      it 'raises an api error' do
        expect { get_pokemon }.to raise_error(ApiError)
      end
    end
  end

  describe '#get_items' do
    context 'when the item name is valid' do
      let(:item_name) { 'master-ball' }
    end

    context 'when the item name is invalid' do
      let(:item_name) { 'false-item' }
    end
  end

  describe '#get_berries' do
    context 'when the berry name is valid' do
      let(:berry_name) { 'cheri' }
    end

    context 'when the berry name is invalid' do
      let(:berry_name) { 'huge-strawberry-cheesecake' }
    end
  end
end
