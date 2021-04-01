class RenameResposesToJobApplications < ActiveRecord::Migration[6.1]
  def change
    rename_table :responses, :job_applications
  end
end
