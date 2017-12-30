class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.references :repository, index: true
      t.timestamps
    end
  end
end
