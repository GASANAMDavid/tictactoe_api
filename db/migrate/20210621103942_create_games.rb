class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :language
      t.string :player_name
      t.string :symbol
      t.array :board, array: true, default: [].yaml
      t.integer :game_mode

      t.timestamps
    end
  end
end
