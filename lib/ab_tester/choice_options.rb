class ABTester::ChoiceOptions
  def initialize(options_hash)
    @total_rank  = 0
    @ranked_keys = []

    options_hash.each do |key, value|
      @total_rank += value
      @ranked_keys << [key, @total_rank]
    end
  end

  def shuffle
    random_value = rand @total_rank
    @ranked_keys.find{ |key, rank| random_value < rank }[0]
  end
end