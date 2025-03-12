require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

  context '正常系' do
    it 'すべての情報が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが適切に入力されていれば登録できる' do
      @user.nickname = 'テストユーザー'
      expect(@user).to be_valid
    end
    it 'emailが正しい形式（@を含む）であれば登録できる' do
      @user.email = 'test@example.com'
      expect(@user).to be_valid
    end
    it 'passwordが6文字以上であれば登録できる' do
      @user.password = 'a00000' 
      @user.password_confirmation = 'a00000'
      expect(@user).to be_valid
    end
    it 'passwordとpassword_confirmationが一致していれば登録できる' do
      @user.password = 'a00000'
      @user.password_confirmation = 'a00000'
      expect(@user).to be_valid
    end
    it 'first_nameとlast_nameが全角日本語であれば登録できる' do
      @user.first_name = '太郎'
      @user.last_name = '田中'
      expect(@user).to be_valid
    end
    it 'first_name_kanaとlast_name_kanaが全角カタカナであれば登録できる' do
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'タナカ'
      expect(@user).to be_valid
    end
  end
  context '異常系' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do 
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do 
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'password_confirmationが空では登録できない' do 
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'first_nameが空では登録できない' do 
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last_nameが空では登録できない' do 
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'first_name_kanaが空では登録できない' do 
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'last_name_kanaが空では登録できない' do 
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'birthdayが空では登録できない' do 
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    it 'emailに@が含まれていないと登録できない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'passwordが6文字未満だと登録できない' do
      @user.password = 'a0000'  # 5文字
      @user.password_confirmation = 'a0000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが英字のみだと登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it 'passwordが数字のみだと登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it 'passwordに全角文字が含まれていると登録できない' do
      @user.password = 'ｐａｓｓｗｏｒｄ123'
      @user.password_confirmation = 'ｐａｓｓｗｏｒｄ123'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
      @user.password_confirmation = 'b00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'first_nameが全角日本語でないと登録できない' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it 'last_nameが全角日本語でないと登録できない' do
      @user.last_name = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it 'first_name_kanaが全角カタカナでないと登録できない' do
      @user.first_name_kana = 'たろう' 
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it 'last_name_kanaが全角カタカナでないと登録できない' do
      @user.last_name_kana = 'やまだ' 
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end
    it 'first_name_kanaに英数字が含まれていると登録できない' do
      @user.first_name_kana = 'タロウ123'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it 'last_name_kanaに英数字が含まれていると登録できない' do
      @user.last_name_kana = 'ヤマダabc'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end
  end
 end
end
