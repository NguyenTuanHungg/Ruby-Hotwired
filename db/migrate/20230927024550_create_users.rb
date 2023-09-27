class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mentor
      t.string :skills
      t.string :payment,default:"not paid"
      t.datetime :time
      t.string :status,default:"pending"

      t.timestamps
    end
  end
end
