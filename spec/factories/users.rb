FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)
    name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
    family_name  {"hoge"}     
    first_name  {"hoge"}      
    family_name_kana {"hoge"}      
    first_name_kana   {"hoge"}      
    birthday_yyyy   {2000}  
    birthday_mm     {01}    
    birthday_dd      {01}    
    authentication_number   {123}
  end
end