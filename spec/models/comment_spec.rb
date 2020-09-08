require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it 'textが存在すれば登録できること' do
      expect(@comment).to be_valid
    end
    it 'textが空では登録できないこと' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include "Textを入力してください"
    end
  end
end
