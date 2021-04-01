# frozen_string_literal: true

class AddColumnJobIdIntoShifts < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :job_id, :integer
  end
end
