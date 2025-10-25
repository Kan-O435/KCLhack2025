class CreateHairModels < ActiveRecord::Migration[8.0]
  def change
    create_table :hair_models do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :model_data, default: {}

      t.timestamps
    end
  end
end
