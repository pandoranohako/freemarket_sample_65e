require 'rails_helper'


RSpec.describe User, type: :model do
  describe '#create' do

    it "nameが空では登録不可" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "nameが16文字以上だと登録不可" do
      user = build(:user, name: "aaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:name][0]).to include("is too long (maximum is 15 characters)")
    end

    it "emailが空では登録不可" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "emailが@を含まないと登録不可 " do
      user = build(:user, email: "aaaaa")
      user.valid?
      expect(user.errors[:email][0]).to include("is invalid")
    end

    it "emailの@の前に文字がないと登録不可 " do
      user = build(:user, email: "@aaa")
      user.valid?
      expect(user.errors[:email][0]).to include("is invalid")
    end

    it "emailの@の後に文字がないと登録不可" do
      user = build(:user, email: "aaaa@")
      user.valid?
      expect(user.errors[:email][0]).to include("is invalid")
    end


    it "passwordが空だと登録不可" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end


    it "password_confirmationが一致しないと登録不可" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end


    it "passwordが6文字以下だと登録不可" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end


    it "first_nameが空だと登録不可" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end


    it "first_nameが16文字以上だと登録不可" do
      user = build(:user, first_name: "瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬")
      user.valid?
      expect(user.errors[:first_name][0]).to include("is too long (maximum is 15 characters)")
    end


    it "first_nameに漢字以外が含まれると登録不可 " do
      user = build(:user, first_name: "瀬瀬a")
      user.valid?
      expect(user.errors[:first_name][0]).to include("is invalid")
    end

    it "family_nameが空だと登録不可" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "family_nameが16文字以上だと登録不可" do
      user = build(:user, family_name: "瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬瀬")
      user.valid?
      expect(user.errors[:family_name][0]).to include("is too long (maximum is 15 characters)")
    end


    it "family_nameに漢字以外が含まれると登録不可 " do
      user = build(:user, family_name: "瀬瀬a")
      user.valid?
      expect(user.errors[:family_name][0]).to include("is invalid")
    end


    it "first_name_kanaが空だと登録不可" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end


    it "first_name_kanaが16文字以上だと登録不可" do
      user = build(:user, first_name_kana: "アアアアアアアアアアアアアアアア")
      user.valid?
      expect(user.errors[:first_name_kana][0]).to include("is too long (maximum is 15 characters)")
    end


    it "first_name_kanaにカナ以外が含まれると登録不可 " do
      user = build(:user, first_name_kana: "トトa")
      user.valid?
      expect(user.errors[:first_name_kana][0]).to include("is invalid")
    end


    it "family_name_kanaが空だと登録不可" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end


    it "family_name_kanaが16文字以上だと登録不可" do
      user = build(:user, family_name_kana: "ウアウアウアウアウアウアウアウア")
      user.valid?
      expect(user.errors[:family_name_kana][0]).to include("is too long (maximum is 15 characters)")
    end


    it "family_name_kanaにカナ以外が含まれると登録不可 " do
      user = build(:user, family_name_kana: "カナa")
      user.valid?
      expect(user.errors[:family_name_kana][0]).to include("is invalid")
    end


    it "birthday_yyyyが空だと登録不可" do
      user = build(:user, birthday_yyyy: nil)
      user.valid?
      expect(user.errors[:birthday_yyyy]).to include("can't be blank")
    end

    it "birthday_mmが空だと登録不可" do
      user = build(:user, birthday_mm: nil)
      user.valid?
      expect(user.errors[:birthday_mm]).to include("can't be blank")
    end

    it "birthday_ddが空だと登録不可" do
      user = build(:user, birthday_dd: nil)
      user.valid?
      expect(user.errors[:birthday_dd]).to include("can't be blank")
    end

    it "すべて満たしていれば登録可" do
      user = build(:user)
      expect(user).to be_valid
    end


  end
end