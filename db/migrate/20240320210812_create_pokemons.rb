# frozen_string_literal: true

class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
