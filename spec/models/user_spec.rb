require 'rails_helper'

describe User do
  describe '#create' do
    it "nameが空では登録不可" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    it "nameが20文字以上だと登録不可" do
      user = build(:user, name: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      user.valid?
      expect(user.errors[:name][0]).to include("is too long")
    end
    it "emailが空では登録不可" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "emailが重複すると登録不可" do
      create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
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
    it "password_confirmationが空だと登録不可" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "passwordが6文字未満だと登録不可" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
    it "family_nameが空だと登録不可" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end
    it "family_nameが21文字以上だと登録不可" do
      user = build(:user, family_name: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      user.valid?
      expect(user.errors[:family_name][0]).to include("is too long")
    end
    it "first_nameが空だと登録不可" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "first_nameが21文字以上だと登録不可" do
      user = build(:user, first_name: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      user.valid?
      expect(user.errors[:first_name][0]).to include("is too long")
    end
    end
    it "family_name_kanaが空だと登録不可" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end
    it "family_name_kanaが21文字以上だと登録不可" do
      user = build(:user, family_name_kana: "アアアアアアアアアアアアアアアアアアアアア")
      user.valid?
      expect(user.errors[:family_name_kana][0]).to include("is too long")
    end
    it "first_name_kanaが空だと登録不可" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end
    it "first_name_kanaが21文字以上だと登録不可" do
      user = build(:user, first_name_kana: "アアアアアアアアアアアアアアアアアアアアア")
      user.valid?
      expect(user.errors[:first_name_kana][0]).to include("is too long")
    end
    it "すべて満たしていれば登録可" do
      user = build(:user)
      expect(user).to be_valid
    end

  end
end 