class CreateNotes < ActiveRecord::Migration
  def change
  	create_table :notes do |t|
  		t.string :topic
  		t.string :content
  		t.integer :user_id
  	end
  end
end
