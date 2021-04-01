# frozen_string_literal: true

class AddColumnShiftIdIntoJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :shift_id, :integer
  end
end
