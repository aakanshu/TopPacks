class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.text     :name
      t.integer :stars_count
      t.integer :forks_count
      t.integer :pakages_count
      t.string  :html_url
      t.boolean :has_packages, default: false
      t.timestamps null: false
    end
  end
end
