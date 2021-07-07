class PlayGameService
  attr_reader :engine, :game_record

  def initialize(engine, game_record)
    @engine = engine
    @game_record = game_record
  end

  def call(move)
    play_game(move)
  end

  private

  def play_game(move)
    engine.play(game_record.symbol, move)
    game_record.board = engine.board
    game_record.save
  end
end
