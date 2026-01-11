require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '異常系' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは必須です')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('eメールは必須です')
      end

      it 'emailに@が含まれていない場合は登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('eメールは不正な値です')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは必須です')
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合での入力が必須です')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合での入力が必須です')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａｂｃ123'
        @user.password_confirmation = 'ａｂｃ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合での入力が必須です')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'pasaward123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード確認とパスワードの入力が一致しません')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓は必須です')
      end

      it '姓(全角)に半角文字が含まれているとと登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓は全角での入力が必須です')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名は必須です')
      end

      it '名(全角)に半角文字が含まれているとと登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('名は全角での入力が必須です')
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.kana_last_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カナ）は全角カタカナでの入力が必須です')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カナ）は必須です')
      end
      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.kana_first_name = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カナ）は全角カタカナでの入力が必須です')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カナ）は必須です')
      end
      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日は必須です')
      end
    end

    context '正常系' do
      it 'すべての情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
  end
end
