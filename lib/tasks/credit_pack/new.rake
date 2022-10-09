namespace :credit_pack do
  desc 'Add credit pack'
  task :new => [:environment] do
    credit_pack = CreditPack.new
    puts "Add credit pack price"
    credit_pack.price = STDIN.gets.chomp

    puts "Add credit pack credits"
    credit_pack.credits = STDIN.gets.chomp

    if credit_pack.save
      puts 'New Credit Pack created.'
    else
      puts 'Could not create credit pack due to following reasons'
      credit_pack.errors.each do |error|
        puts error.full_message
      end
    end
  end
end
