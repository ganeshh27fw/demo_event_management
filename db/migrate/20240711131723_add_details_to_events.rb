class AddDetailsToEvents < ActiveRecord::Migration[5.2]
  def change
    
    
    add_column :events, :artists, :text
  end
end
