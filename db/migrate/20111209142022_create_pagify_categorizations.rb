class CreatePagifyCategorizations < ActiveRecord::Migration
  def change
    create_table :pagify_categorizations do |t|
      t.integer :page_id
      t.integer :category_id
      t.integer :position

      t.timestamps
    end
  end
end
