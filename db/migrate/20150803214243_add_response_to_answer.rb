class AddResponseToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :response, :boolean
  end
end
