class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :client_id
      t.boolean :outbound
      t.boolean :inbound
      t.datetime :created_at
    end
  end
end
