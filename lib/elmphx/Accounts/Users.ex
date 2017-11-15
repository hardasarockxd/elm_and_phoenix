defmodule Elmphx.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :name, :age]}

  schema "users" do
    field :name, :string
    field :age, :integer

    timestamps()
  end

  def changeset(struct, new_struct \\ %{}) do
    struct
    |> cast(new_struct, [:name, :age])
    |> validate_required([:name, :age])
  end

end
