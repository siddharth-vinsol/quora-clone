FactoryBot.define do
  factory :user do
    name { 'user1' }
    sequence :email do |n|
      "user#{n}@user.com"
    end
    sequence :username do |n|
      "user#{n}"
    end
    password { 'Password@123' }
    password_confirmation { 'Password@123' }
    credits { 0 }

    factory :user_with_png_profile_image do
      profile_image { Rack::Test::UploadedFile.new('spec/files/profile-image.png') }
    end

    factory :user_with_jpeg_profile_image do
      profile_image { Rack::Test::UploadedFile.new('spec/files/profile-image.jpeg') }
    end

    factory :user_with_pdf_profile_image do
      profile_image { Rack::Test::UploadedFile.new('spec/files/profile-image.pdf') }
    end

    factory :user_with_questions do
      transient do
        questions_count { 2 }
      end

      after(:create) do |user, evaluator|
        build_list(:question, evaluator.questions_count, user: user)
      end
    end
  end
end
