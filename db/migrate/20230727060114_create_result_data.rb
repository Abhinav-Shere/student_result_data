class CreateResultData < ActiveRecord::Migration[6.0]
  def change
    create_table :result_data do |t|
      t.string :subject
      t.datetime :timestamp
      t.float :marks

      t.timestamps
    end
  end
end
