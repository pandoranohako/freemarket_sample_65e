FactoryBot.define do

  factory :user do
    password = Faker::Internet.password(min_length: 8)
    name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
    family_name  {"山田"}     
    first_name  {"真之介"}      
    family_name_kana {"ヤマダ"}      
    first_name_kana   {"シンノスケ"}      
    birthday_yyyy   {2000}  
    birthday_mm     {01}    
    birthday_dd      {01}    
    authentication_number   {123}
  end

end