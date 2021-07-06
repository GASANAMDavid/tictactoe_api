FactoryBot.define do
  factory :game do
    id { 1 }
    language { 'en' }
    player_name { 'David' }
    symbol { 'X' }
    board { [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']] }
    game_mode { 2 }
  end
end
