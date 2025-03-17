require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

describe '商品出品機能' do
  context '正常系' do
    it 'すべての情報が正しく入力されていれば保存できる' do
      expect(@item).to be_valid
    end

    it '画像が適切に添付されていれば登録できる' do
      expect(@item.image).to be_attached
      expect(@item).to be_valid
    end

    it '商品名が適切に入力されていれば登録できる' do
      @item.name = 'テスト商品'
      expect(@item).to be_valid
    end

    it '商品名が40文字以内であれば登録できる' do
      @item.name = 'あ' * 40
      expect(@item).to be_valid
    end

    it '商品説明が適切に入力されていれば登録できる' do
      @item.description = 'これはテスト用の商品です。'
      expect(@item).to be_valid
    end

    it '商品説明が1000文字以内であれば登録できる' do
      @item.description = 'あ' * 1000
      expect(@item).to be_valid
    end

    it 'カテゴリーが適切に選択されていれば登録できる' do
      @item.category_id = 2
      expect(@item).to be_valid
    end

    it '商品の状態が適切に選択されていれば登録できる' do
      @item.status_id = 2
      expect(@item).to be_valid
    end

    it '配送料の負担が適切に選択されていれば登録できる' do
      @item.shipping_id = 2
      expect(@item).to be_valid
    end

    it '発送元の地域が適切に選択されていれば登録できる' do
      @item.prefecture_id = 2
      expect(@item).to be_valid
    end

    it '発送までの日数が適切に選択されていれば登録できる' do
      @item.shipping_day_id = 2
      expect(@item).to be_valid
    end

    it '価格が300円以上であれば登録できる' do
      @item.price = 300
      expect(@item).to be_valid
    end

    it '価格が9999999円以下であれば登録できる' do
      @item.price = 9_999_999
      expect(@item).to be_valid
    end

    it '価格が整数であれば登録できる' do
      @item.price = 500
      expect(@item).to be_valid
    end
  end

  context '異常系' do
    it '画像が添付されていないと保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空では保存できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品名が40文字を超えると保存できない' do
      @item.name = 'a' * 41
      @item.valid?
      expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
    end

    it '商品説明が空では保存できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it '商品説明が1000文字を超えると保存できない' do
      @item.description = 'a' * 1001
      @item.valid?
      expect(@item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
    end

    it 'カテゴリーが空では保存できない' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 0")
    end

    it '商品の状態が空では保存できない' do
      @item.status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 0")
    end

    it '配送料の負担が空では保存できない' do
      @item.shipping_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping must be other than 0")
    end

    it '発送元の地域が空では保存できない' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
    end

    it '発送までの日数が空では保存できない' do
      @item.shipping_day_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping day must be other than 0")
    end

    it '価格が空では保存できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300円未満では保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it '価格が10,000,000円以上では保存できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than 10000000")
    end

    it '価格が整数でない場合は保存できない' do
      @item.price = 300.5
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be an integer")
    end

    it 'ユーザーが紐づいていないと保存できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
end