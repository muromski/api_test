# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :salary
      t.json :languages

      t.timestamps
    end
  end
end
