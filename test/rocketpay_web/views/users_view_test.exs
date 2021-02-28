defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  import Phoenix.View

  alias Rocketpay.{Account, User}

  test "render create.json" do
    params = %{
      name: "Renato",
      password: "010203",
      nickname: "tato",
      email: "tato@email.com",
      age: 27
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.Users.Create.call(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    expect_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Renato",
        nickname: "tato"}
    }

    assert expect_response == response
  end

end
