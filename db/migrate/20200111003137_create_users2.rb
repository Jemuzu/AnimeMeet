class CreateUsers2 < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
  t.string :name
  t.string :email
  t.string :password
  t.date :birth
  t.string :bio
end
  end
end
