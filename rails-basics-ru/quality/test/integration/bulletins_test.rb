require_relative "../test_helper"

class BulletinsTest < ActionDispatch::IntegrationTest
  test 'opens all bulletins page' do
    get bulletins_path
    assert_response :success
  end

  test 'opens bulletins page' do
    @bulletin_1 = bulletins[0]
    get bulletin_path(@bulletin_1)
    assert_response :success
  end
end
