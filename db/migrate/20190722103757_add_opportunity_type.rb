class AddOpportunityType < ActiveRecord::Migration[5.2]
  def change
    add_column :opportunities, :type, :string
    add_column :opportunities, :role, :string
  end
end
