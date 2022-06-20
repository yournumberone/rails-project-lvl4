class Rename < ActiveRecord::Migration[6.1]
  def change
    rename_column :repository_checks, :status, :aasm_state
  end
end
