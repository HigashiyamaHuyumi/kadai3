class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      add_column :books, :title, :string
      add_column :books, :opinion, :text

      t.timestamps
    end
  end
end
