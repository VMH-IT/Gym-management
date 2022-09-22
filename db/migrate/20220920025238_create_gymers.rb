class CreateGymers < ActiveRecord::Migration[7.0]
  def change
    create_table :gymers do |t|
      t.string :name       
      t.string :email, null: false       
      t.string :encrypted_password, null:false       
      t.string :phoneNumber       
      t.text   :address       
      t.integer :age      
      t.integer :gender       

      t.timestamps
    end
  end
end
