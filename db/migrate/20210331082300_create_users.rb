class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :global_balance
      t.decimal :incoming_transactions, default: 0
      t.decimal :outgoing_transactions, default: 0

      t.timestamps
    end
  end
end
