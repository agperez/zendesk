require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post :create, ticket: { assignee: @ticket.assignee, closed: @ticket.closed, closed_time: @ticket.closed_time, first_assigned: @ticket.first_assigned, opened: @ticket.opened, product: @ticket.product, reply_time: @ticket.reply_time, zenid: @ticket.zenid }
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket
    assert_response :success
  end

  test "should update ticket" do
    patch :update, id: @ticket, ticket: { assignee: @ticket.assignee, closed: @ticket.closed, closed_time: @ticket.closed_time, first_assigned: @ticket.first_assigned, opened: @ticket.opened, product: @ticket.product, reply_time: @ticket.reply_time, zenid: @ticket.zenid }
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to tickets_path
  end
end
