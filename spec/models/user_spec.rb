require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '正常に登録できる' do
        expect(@user).to be_valid
      end
      it '漢字氏名（氏）について、全角（漢字・ひらがな・カタカナ）を許容すること' do
        @user.kanji_name_sei = '阿あア'
        expect(@user).to be_valid
      end
      it '漢字氏名（名）について、全角（漢字・ひらがな・カタカナ）を許容すること' do
        @user.kanji_name_mei = '阿あア'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'ニックネームがブランクの場合は登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスがブランクの場合は登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスがDB上に存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含まない場合は登録できない' do
        @user.email = 'testemail.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードがブランクの場合は登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字未満の場合は登録できない' do
        @user.password = 'pass1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英数字混合での入力でない（英字のみ）場合は登録できない' do
        @user.password = 'pstest'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが半角英数字混合での入力でない（数字のみ）場合は登録できない' do
        @user.password = '222222'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードとパスワード（確認）の値が一致していない場合は登録できない' do
        @user.password = 'test1235'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '漢字氏名（氏）がブランクの場合は登録できない' do
        @user.kanji_name_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji name sei can't be blank")
      end
      it '漢字氏名（名）がブランクの場合は登録できない' do
        @user.kanji_name_mei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji name mei can't be blank")
      end
      it '漢字氏名（氏）が半角文字（カナ）を含む場合は登録できない' do
        @user.kanji_name_sei = '漢ｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name sei is invalid')
      end
      it '漢字氏名（氏）が半角文字（英字）を含む場合は登録できない' do
        @user.kanji_name_sei = '漢a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name sei is invalid')
      end
      it '漢字氏名（氏）が半角文字（数字）を含む場合は登録できない' do
        @user.kanji_name_sei = '漢1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name sei is invalid')
      end
      it '漢字氏名（氏）が半角文字（記号）を含む場合は登録できない' do
        @user.kanji_name_sei = '漢@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name sei is invalid')
      end
      it '漢字氏名（名）が半角文字（カナ）を含む場合は登録できない' do
        @user.kanji_name_mei = '漢ｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name mei is invalid')
      end
      it '漢字氏名（名）が半角文字（英字）を含む場合は登録できない' do
        @user.kanji_name_mei = '漢a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name mei is invalid')
      end
      it '漢字氏名（名）が半角文字（数字）を含む場合は登録できない' do
        @user.kanji_name_mei = '漢1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name mei is invalid')
      end
      it '漢字氏名（名）が半角文字（記号）を含む場合は登録できない' do
        @user.kanji_name_mei = '漢@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji name mei is invalid')
      end
      it 'カナ氏名（氏）がブランクの場合は登録できない' do
        @user.kana_name_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei can't be blank")
      end
      it 'カナ氏名（名）がブランクの場合は登録できない' do
        @user.kana_name_mei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei can't be blank")
      end
      it 'カナ氏名（氏）が全角漢字を含む場合は登録できない' do
        @user.kana_name_sei = 'カナ漢'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（氏）が全角ひらがなを含む場合は登録できない' do
        @user.kana_name_sei = 'カナあ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（氏）が半角文字（カナ）場合は登録できない' do
        @user.kana_name_sei = 'カナｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（氏）が半角文字（英字）を場合は登録できない' do
        @user.kana_name_sei = 'カナa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（氏）が半角文字（数字）を含む場合は登録できない' do
        @user.kana_name_sei = 'カナ1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（氏）が半角文字（記号）を含む場合は登録できない' do
        @user.kana_name_sei = 'カナ@'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name sei is invalid")
      end
      it 'カナ氏名（名）がブランクの場合は登録できない' do
        @user.kana_name_mei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei can't be blank")
      end
      it 'カナ氏名（名）が全角漢字を含む場合は登録できない' do
        @user.kana_name_mei = 'カナ漢'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it 'カナ氏名（名）が全角ひらがなを含む場合は登録できない' do
        @user.kana_name_mei = 'カナあ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it 'カナ氏名（名）が半角文字（カナ）を含む場合は登録できない' do
        @user.kana_name_mei = 'カナｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it 'カナ氏名（名）が半角文字（英字）を含む場合は登録できない' do
        @user.kana_name_mei = 'カナa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it 'カナ氏名（名）が半角文字（数字）を含む場合は登録できない' do
        @user.kana_name_mei = 'カナ1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it 'カナ氏名（名）が半角文字（記号）を含む場合は登録できない' do
        @user.kana_name_mei = 'カナ@'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name mei is invalid")
      end
      it '生年月日がブランクの場合は登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
