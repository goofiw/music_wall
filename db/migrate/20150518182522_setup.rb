class Setup < ActiveRecord::Migration
  def up
  	create_table :songs do |t|
  		t.string :song_title
  		t.string :author
  		t.string :url
  		t.timestamps
  		
  	end
  end
end
