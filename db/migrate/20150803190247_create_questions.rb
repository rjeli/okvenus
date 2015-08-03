class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end
