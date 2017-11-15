# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elmphx.Repo.insert!(%Elmphx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Elmphx.Repo.insert!(%Elmphx.Accounts.Users{name: "Yegor", age: 18})
Elmphx.Repo.insert!(%Elmphx.Accounts.Users{name: "Kirill", age: 18})
Elmphx.Repo.insert!(%Elmphx.Accounts.Users{name: "John", age: 18})
Elmphx.Repo.insert!(%Elmphx.Accounts.Users{name: "Jack", age: 100})
