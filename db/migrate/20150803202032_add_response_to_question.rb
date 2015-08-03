class AddResponseToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :response, :boolean
  end
end
