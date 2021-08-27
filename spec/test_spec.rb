require 'rails_helper'

describe '投稿のテスト' do
  let!(:item) { create(:item,name:'hoge',brand:'body') }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)にマイページへのリンクが表示されているか' do
        expect(page).to have_link "", href: mypage_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe "マイページ画面のテスト" do
    before do
      visit mypage_path
    end
    context 'ユーザー情報の表示とリンクの確認' do
      it "ユーザー情報表示(tableタグ)と各リンクが同一画面に表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_link "", href: user_bookmarks_path
        expect(page).to have_link "", href: user_items_path
        expect(page).to have_link "", href: user_categories_path
        expect(page).to have_link "", href: user_styles_path
        expect(page).to have_link "", href: user_item_reviews_path
      end
    end
  end
  describe "アイテム一覧画面のテスト" do
    before do
      visit user_items_path
    end
    context '一覧の表示とリンクの確認' do
      it "アイテムのの一覧表示(card)表示されているか、新規登録リンクがあるか" do
        expect(page).to have_selector 'card'
        expect(page).to have_link "", href: new_user_item_path
      end
      it "アイテムの名前とブランドを表示しているか" do
          (1..5).each do |i|
            Item.create(name:'hoge'+i.to_s,brand:'brand'+i.to_s)
          end
          visit user_items_path
          Book.all.each_with_index do |book,i|
            j = i * 3
            expect(page).to have_content item.name
            expect(page).to have_content item.brand
            # Showリンク
            show_link = find_all('a')[j]
            expect(show_link.native.inner_text).to match(/show/i)
            expect(show_link[:href]).to eq user_item_path(item)
          end
        end
      end
  end
  describe "アイテム新規登録画面のテスト" do
    before do
      visit new_user_item_path
    end
  context '一覧の表示とリンクの確認' do
      it "投稿フォームが表示されているか" do
        expect(page).to have_field 'item[name]'
        expect(page).to have_field 'item[brand]'
      end
      it 'Create Bookボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit user_item_path(item)
    end
    context '表示の確認' do
      it 'アイテムの名前が画面に表示されていること' do
        expect(page).to have_content item.name
      end
      it '関連アイテムリンクが表示される' do
        expect(page).to have_link "", href: user_item_related_items_confirm_path(user, item)
			end
      it 'reviewリンクが表示される' do
        expect(page).to have_link "", href: user_item_review_path(user, item, review)
			end
    end
  end
  describe 'アイテム編集画面のテスト' do
    before do
      visit edit_user_item_path(book)
    end
    context '表示の確認' do
      it '編集前の文言がフォームに表示(セット)されている' do
        expect(page).to have_field 'item[name]', with: item.name
        expect(page).to have_field 'item[brand]', with: item.brand
      end
      it 'Update Bookボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end
    context '更新処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'item[name]', with: ""
        click_button '更新'
        expect(page).to have_content 'エラー'
      end
    end
  end
end