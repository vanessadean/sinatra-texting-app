class RemoveInboundFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :inbound, :boolean
  end
end
