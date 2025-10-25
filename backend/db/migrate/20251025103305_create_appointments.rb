class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :appointment_date
      t.string :salon_name
      t.string :salon_id
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
