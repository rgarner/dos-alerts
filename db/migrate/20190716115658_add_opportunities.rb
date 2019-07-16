class AddOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :opportunities do |t|
      t.string :original_url, null: false
      t.integer :original_id

      t.date :tweeted_at
      t.timestamps
    end

    add_index :opportunities, :original_url, unique: true
    add_index :opportunities, :original_id, unique: true
  end
end
