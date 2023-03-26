# frozen_string_literal: true

class AddColumnShiftsIntoJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :shifts, :string
  end
end
