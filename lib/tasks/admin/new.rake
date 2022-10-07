namespace :admin do
  desc 'Create admin with valid details'
  task :new => [:environment] do
    admin = User.new
    print 'Admin Name: '
    admin.name = STDIN.gets.chomp

    print 'Admin Email: '
    admin.email = STDIN.gets.chomp

    print 'Admin Username: '
    admin.username = STDIN.gets.chomp

    puts 'Admin password: '
    admin.password = STDIN.noecho(&:gets).chomp

    puts 'Confirm Password: '
    admin.password_confirmation = STDIN.noecho(&:gets).chomp

    admin.role = 0
    admin.verified_at = Time.now

    if admin.save
      puts 'New Admin created.'
    else
      puts 'Could not create admin due to following reasons'
      admin.errors.each do |error|
        puts error.full_message
      end
    end
  end
end
