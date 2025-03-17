require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入' do
    context '正常系' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end

      it '郵便番号が適切に入力されていれば購入できる' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end

      it '都道府県が適切に入力されていれば購入できる' do
        @order_address.prefecture_id = 1
        expect(@order_address).to be_valid
      end

      it '市区町村が適切に入力されていれば購入できる' do
        @order_address.city = '渋谷区'
        expect(@order_address).to be_valid
      end

      it '番地が適切に入力されていれば購入できる' do
        @order_address.block = '渋谷1-2-3'
        expect(@order_address).to be_valid
      end

      it '建物名が適切に入力されていれば購入できる' do
        @order_address.building = 'ヒカリエ10F'
        expect(@order_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end

      it '電話番号が10桁の場合でも購入できる' do
        @order_address.phone_number = '0312345678'
        expect(@order_address).to be_valid
      end

      it '電話番号が11桁の場合でも購入できる' do
        @order_address.phone_number = '09012345678'
        expect(@order_address).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号が空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '郵便番号が「3桁ハイフン4桁」でない場合は購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '都道府県が空では購入できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short")
      end

      it '電話番号が12桁以上では購入できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it '電話番号にハイフンが含まれていると購入できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'user_idが空では購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end