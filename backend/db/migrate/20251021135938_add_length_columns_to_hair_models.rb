class AddLengthColumnsToHairModels < ActiveRecord::Migration[8.0]
  def change
    add_column :hair_models, :current_length, :integer
    add_column :hair_models, :target_length, :integer
    add_column :hair_models, :ideal_length, :integer
    add_column :hair_models, :max_length, :integer
    add_column :hair_models, :daily_growth_rate, :decimal
  end
end
