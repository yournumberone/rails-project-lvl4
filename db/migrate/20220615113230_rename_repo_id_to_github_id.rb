class RenameRepoIdToGithubId < ActiveRecord::Migration[6.1]
  def change
    rename_column :repositories, :repo_id, :github_id
  end
end
