class CreatePagifyCategories < ActiveRecord::Migration
  def change
    create_table :pagify_categories do |t|
      t.string :name

      t.timestamps
    end
  end
  add_index :pagify_categories, :name, :unique => true

end
