defmodule App.TimerTest do
  use App.DataCase
  alias App.{Item, Timer}

  describe "timers" do
    @valid_item_attrs %{text: "some text", person_id: 1}
    # @update_attrs %{text: "some updated text", status: 1}
    # @invalid_attrs %{text: nil}


    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_item_attrs)
        |> Item.create_item()

      item
    end

    test "Timer.start!/1 returns timer that has been started" do
      item = item_fixture(@valid_item_attrs)
      assert Item.get_item!(item.id) == item

      started = NaiveDateTime.utc_now
      {:ok, timer} = Timer.start(%{item_id: item.id, person_id: 1, start: started})
      assert NaiveDateTime.diff(timer.start, started) == 0
    end
  end
end