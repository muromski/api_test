# frozen_string_literal: true

class RenameNameToEmail < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :name, :email
  end
end
