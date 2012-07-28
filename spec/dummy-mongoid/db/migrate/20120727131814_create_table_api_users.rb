class CreateTableApiUsers < ActiveRecord::Migration
  def change
    create_table :api_users do |t|
      t.string :secret
    end
  end
end
