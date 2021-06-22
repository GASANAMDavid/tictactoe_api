FactoryBot.define do
  factory :game do
    language { 'en' }
    player_name { 'David' }
    symbol { 'X' }
    board { [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']] }
    game_mode { 1 }
  end
end
