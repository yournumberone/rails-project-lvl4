class AddBranchToRepo < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :default_branch, :string
    add_column :repository_checks, :commit, :string
  end
end
