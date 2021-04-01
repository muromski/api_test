# frozen_string_literal: true

class DeleteColumnShiftIdIntoJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :shift_id
  end
end
