class CreatePagifyCategories < ActiveRecord::Migration
  def change
    create_table :pagify_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
