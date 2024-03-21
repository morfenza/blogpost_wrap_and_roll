# frozen_string_literal: true

class CreateBerries < ActiveRecord::Migration[7.1]
  def change
    create_table :berries do |t|
      t.string :name
      t.integer :size
      t.integer :smoothness

      t.timestamps
    end
  end
end
