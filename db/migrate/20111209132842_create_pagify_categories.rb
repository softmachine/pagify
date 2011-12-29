class CreatePagifyCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :categories, :name, :unique => true
  end

end
