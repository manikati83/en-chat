class AddOnlineToPools < ActiveRecord::Migration[5.2]
  def change
    add_column :pools, :online, :boolean, default: :false
  end
end
