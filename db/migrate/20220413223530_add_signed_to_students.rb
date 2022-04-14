class AddSignedToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :signed, :boolean, :default => false
  end
end

#class CreateAssembliesPartsJoinTable < ActiveRecord::Migration[5.0]
#  def change
#    create_join_table :assemblies, :parts do |t|
#      t.index :assembly_id
#      t.index :part_id
#    end
#  end
#end
