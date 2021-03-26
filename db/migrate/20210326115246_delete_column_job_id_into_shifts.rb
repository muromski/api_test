class DeleteColumnJobIdIntoShifts < ActiveRecord::Migration[6.1]
  def change
    remove_column :shifts, :job_id
  end
end
