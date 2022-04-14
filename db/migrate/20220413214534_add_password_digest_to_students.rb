class AddPasswordDigestToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :password_digest, :string
  end
    
  def change
      add_column :students, :signed, :boolean, :default=>false
  end
end
