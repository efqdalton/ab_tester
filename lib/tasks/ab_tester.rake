namespace :ab_tester do
  desc "Generate Statistics"
  task :stats => :environment do
    all_successful_choices = ABChoice.group(:choice).where(:success => true).count
    all_choices            = ABChoice.group(:choice).count

    max_choice_char_size = all_choices.keys.map{ |c| c.to_s.size }.max + 1

    puts "Choices:"
    all_choices.each do |choice, all_count|
      puts format("  %-#{max_choice_char_size}s: %2.2f (%d/%d)", choice, all_successful_choices[choice].to_f*100/all_count, all_successful_choices[choice], all_count)
    end
  end

  desc "I cant believe that this description is required if you want to know what it does!"
  task :reset => :environment do
    ABChoice.reset!
  end

  desc "Outputs a tsv file that has all data"
  task :dump => :environment do
    ABChoice.all.each do |c|
      puts [c.identity_hash, c.success, c.choice, c.succeeded_at, c.created_at].join("\t")
    end
  end
end