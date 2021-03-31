class CreateTransacts < ActiveRecord::Migration[5.2]
  def change
    create_table :transacts do |t|
      t.decimal :incoming_transactions, default: 0
      t.decimal :outgoing_transactions, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
