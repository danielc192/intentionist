class CreateProviders < ActiveRecord::Migration
  def change
      add_column :providers, :apikey, :string
  end
end
