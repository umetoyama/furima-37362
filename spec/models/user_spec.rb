require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it '全ての値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'nicknameは空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailは空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは英数字のみです", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角日本語のみです")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角日本語のみです")
      end
      it 'last_name_readが空では登録できない' do
        @user.last_name_read = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください", "苗字（カナ）は全角カタカナのみです")
      end
      it 'first_name_readが空では登録できない' do
        @user.first_name_read = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください", "名前（カナ）は全角カタカナのみです")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it '重複したemailが存在するが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが5文字以下では登録できいない' do
        @user.password = '55555'
        @user.password_confirmation = '55555'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください', 'パスワードは英数字のみです')
      end
      it '英字のみのpasswordでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英数字のみです')
      end
      it '数字のみのpasswordでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英数字のみです')
      end
      it '全角文字を含むpasswordは登録できない' do
        @user.password = 'ａａａａａａ'
        @user.password_confirmation = 'ａａａａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英数字のみです')
      end
      it 'last_nameに半角文字が含まれていると登録できない' do
        @user.last_name = 'ｱｱｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は全角日本語のみです')
      end
      it 'first_nameに半角文字が含まれていると登録できない' do
        @user.first_name = 'ｱｱｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角日本語のみです')
      end
      it 'last_name_readにカタカナ以外の文字が含まれていると登録できない' do
        @user.last_name_read = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（カナ）は全角カタカナのみです')
      end
      it 'first_name_readにカタカナ以外の文字が含まれていると登録できない' do
        @user.first_name_read = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナのみです')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
    end
  end
end
