require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "creating a Transaction" do
    visit transactions_url
    click_on "New Transaction"

    fill_in "Account", with: @transaction.account_id
    fill_in "Address 1", with: @transaction.address_1
    fill_in "Address 2", with: @transaction.address_2
    fill_in "Amount", with: @transaction.amount
    fill_in "Auth code", with: @transaction.auth_code
    fill_in "Backend", with: @transaction.backend_id
    fill_in "Bank name", with: @transaction.bank_name
    fill_in "Bluepay", with: @transaction.bluepay_id
    fill_in "City", with: @transaction.city
    fill_in "Email", with: @transaction.email
    fill_in "First name", with: @transaction.first_name
    fill_in "Last name", with: @transaction.last_name
    fill_in "Memo", with: @transaction.memo
    fill_in "Message", with: @transaction.message
    fill_in "Payment type", with: @transaction.payment_type
    fill_in "Phone", with: @transaction.phone
    fill_in "Rebilling", with: @transaction.rebilling_id
    fill_in "Settlment", with: @transaction.settlment_id
    fill_in "State", with: @transaction.state
    fill_in "Status", with: @transaction.status
    fill_in "Zip code", with: @transaction.zip_code
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "updating a Transaction" do
    visit transactions_url
    click_on "Edit", match: :first

    fill_in "Account", with: @transaction.account_id
    fill_in "Address 1", with: @transaction.address_1
    fill_in "Address 2", with: @transaction.address_2
    fill_in "Amount", with: @transaction.amount
    fill_in "Auth code", with: @transaction.auth_code
    fill_in "Backend", with: @transaction.backend_id
    fill_in "Bank name", with: @transaction.bank_name
    fill_in "Bluepay", with: @transaction.bluepay_id
    fill_in "City", with: @transaction.city
    fill_in "Email", with: @transaction.email
    fill_in "First name", with: @transaction.first_name
    fill_in "Last name", with: @transaction.last_name
    fill_in "Memo", with: @transaction.memo
    fill_in "Message", with: @transaction.message
    fill_in "Payment type", with: @transaction.payment_type
    fill_in "Phone", with: @transaction.phone
    fill_in "Rebilling", with: @transaction.rebilling_id
    fill_in "Settlment", with: @transaction.settlment_id
    fill_in "State", with: @transaction.state
    fill_in "Status", with: @transaction.status
    fill_in "Zip code", with: @transaction.zip_code
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transaction" do
    visit transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transaction was successfully destroyed"
  end
end
