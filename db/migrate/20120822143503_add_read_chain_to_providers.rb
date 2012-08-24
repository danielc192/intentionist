class AddReadChainToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :read_chain, :string
  end
end
