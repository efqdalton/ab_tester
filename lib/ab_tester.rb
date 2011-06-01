require 'rails'

autoload :ABChoice,       'ab_choice'
autoload :ABChoiceHelper, 'helpers/ab_choice_helper'

ActionView::Base.class_eval do
  include ABChoiceHelper
end

module ABTester
  autoload :ChoiceOptions, 'ab_tester/choice_options'

  def find_or_create_choice(choice_value = self.class.ab_options.shuffle)
    ab_choice = ABChoice.find_or_create_by_identity_hash identity_hash
    ab_choice.update_attribute(:choice, @selected_choice_value || choice_value) unless ab_choice.choice
    ab_choice
  end

  def choose(selected_choice_value)
    @selected_choice_value = selected_choice_value
  end

  def ab_choice(selected_choice_value, &block)
    @ab_choice ||= find_or_create_choice

    if @ab_choice.choice == selected_choice_value.to_s
      yield
    else
      nil
    end
  end

  module ClassMethods
    def ab_test(options_hash)
      @ab_options = ChoiceOptions.new options_hash
    end

    def ab_options
      @ab_options or raise "Choices definitions missing! Call at_test method on controller!"
    end
  end

  def self.included(base)
    base.send :extend,        ABTester::ClassMethods
    base.send :protected,     :ab_choice
    base.send :helper_method, :choose
    base.send :helper_method, :identity_hash
    base.send :helper_method, :find_or_create_choice
  end

  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/ab_tester.rake"
    end
  end
end