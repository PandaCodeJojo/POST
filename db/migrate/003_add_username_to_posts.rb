class AddUsernameToPosts <ActiveRecord::Migration[5.0]
    def change 
        add_column :posts, :username, :string
    end
end