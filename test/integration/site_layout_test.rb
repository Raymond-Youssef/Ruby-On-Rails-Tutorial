require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:raymond)
    end

    test "layout links" do
        get root_path
        assert_select "title", full_title
        assert_template 'static_pages/home'
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
    end

    test "should not have links when not logged in" do
        get root_path
        assert_select "a[href=?]", login_path
        assert_select "a[href=?]", users_path, count: 0
        assert_select "a[href=?]", user_path(@user), count: 0
        assert_select "a[href=?]", edit_user_path(@user), count: 0
        assert_select "a[href=?]", logout_path, count: 0
    end

    test "should have links when logged in " do
        log_in_as(@user)
        get root_path
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", users_path
        assert_select "a[href=?]", user_path(@user)
        assert_select "a[href=?]", edit_user_path(@user)
        assert_select "a[href=?]", logout_path
    end
end
