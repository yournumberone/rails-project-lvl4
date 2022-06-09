class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.references :repository
      t.string :status

      t.timestamps
    end
  end
end
