require 'test_helper'

class SubHeadsControllerTest < ActionController::TestCase
  setup do
    @sub_head = sub_heads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_heads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_head" do
    assert_difference('SubHead.count') do
      post :create, sub_head: { many_cons: @sub_head.many_cons, title: @sub_head.title }
    end

    assert_redirected_to sub_head_path(assigns(:sub_head))
  end

  test "should show sub_head" do
    get :show, id: @sub_head
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_head
    assert_response :success
  end

  test "should update sub_head" do
    put :update, id: @sub_head, sub_head: { many_cons: @sub_head.many_cons, title: @sub_head.title }
    assert_redirected_to sub_head_path(assigns(:sub_head))
  end

  test "should destroy sub_head" do
    assert_difference('SubHead.count', -1) do
      delete :destroy, id: @sub_head
    end

    assert_redirected_to sub_heads_path
  end
end
