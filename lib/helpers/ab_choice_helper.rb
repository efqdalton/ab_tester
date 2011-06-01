module ABChoiceHelper
  def ab_choice(selected_choice_value, &block)
    @ab_choice ||= find_or_create_choice

    if @ab_choice.choice == selected_choice_value.to_s
      capture &block
    else
      nil
    end
  end
end