class AddCreatedAtToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :created_at, :datetime
  end
end
