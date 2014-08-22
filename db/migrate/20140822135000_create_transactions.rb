class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :client_id
      t.string :name
      t.string :type_code
      t.string :status
      t.string :reference_number
      t.string :vendor_id
      t.string :agent_id
      t.references :air_booking, index: true

      t.timestamps
    end
  end
end
