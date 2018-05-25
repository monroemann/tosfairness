class CreateUpdateRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :update_requests do |t|
      t.integer :company_id
      t.text    :request_note
      t.text    :status
      
      t.timestamps
    end
  end
end
