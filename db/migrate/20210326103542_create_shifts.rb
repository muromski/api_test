# frozen_string_literal: true

class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
