class Setup < ActiveRecord::Migration
  def up

  	create_table :songs do |t|
  		t.belongs_to :user
  		t.string :song_title
  		t.string :user
  		t.string :url
  		t.belongs_to :user, index: true
  		t.timestamps
		end

  		create_table :users do |t|
  		t.string :username
  		t.string :password
  		t.timestamps
  	end
  	
  end
end
