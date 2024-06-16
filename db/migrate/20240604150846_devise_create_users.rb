# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Omniauthable
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
