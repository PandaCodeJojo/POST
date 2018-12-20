class CreatePosts < ActiveRecord::Migration[5.0]
    def up
        create_table :posts do |t|
            t.string :title
            t.string :content
            t.references :user
             end 
    end 

    def down
        drop_table :posts
    end
end
