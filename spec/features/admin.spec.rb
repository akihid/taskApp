require 'rails_helper'

RSpec.feature "会員登録機能", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
    visit new_session_path
    fill_in 'session[mail]', with: 'test2@co.jp'
    fill_in 'session[password]', with: '111111'
    click_on '登録'
  end
  scenario "会員登録成功" do

    visit new_admin_user_path

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'test@co.jp'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'

    click_on '登録'
    expect(page).to have_content '会員登録しました'
    expect(page).to have_content '管理画面'

  end

  scenario "会員登録失敗" do

    visit new_admin_user_path

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'test@co.jp'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '1234567'

    click_on '登録'

    expect(page).to have_content 'エラーがあります'

  end

  scenario "会員更新成功" do

    visit edit_admin_user_path(@user.id)

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'update@co.jp'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'

    click_on '登録'

    expect(page).to have_content '会員更新しました'
    expect(page).to have_content '管理画面'

  end

  scenario "会員更新失敗" do

    visit edit_admin_user_path(@user.id)

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'update@co.jp'
    fill_in 'user[password]', with: '1234568'
    fill_in 'user[password_confirmation]', with: '123456'

    click_on '登録'

    expect(page).to have_content 'エラーがあります'

  end

  scenario "会員削除" do

    visit admin_users_path
    click_on '削除', match: :first

    expect(page).to have_content '会員削除しました'
  end

  scenario "会員新規登録画面遷移" do

    visit admin_users_path
    click_on '新規作成'

    expect(page).to have_content '会員登録'

  end

  scenario "会員編集画面遷移" do

    visit admin_users_path
    click_on '編集', match: :first

    expect(page).to have_content '会員情報更新'

  end

  scenario "会員情報詳細画面遷移" do

    visit admin_users_path
    click_on '詳細', match: :first

    expect(page).to have_content '会員情報'

  end

end