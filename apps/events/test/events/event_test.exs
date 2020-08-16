defmodule Event.EventTest do
  use ExUnit.Case, async: true
  alias Ecto.Changeset
  alias Events.Event

  describe "creating new events" do
    test ":event_start needs to be before :event_end" do
      now = DateTime.utc_now()

      # Create event start after event end
      bad_params = %{
        event_start: now,
        event_end: DateTime.add(now, -100, :second)
      }

      assert %Changeset{valid?: false, errors: errors} =
               Event.new_event_changeset(%Event{}, bad_params)

      assert Keyword.has_key?(errors, :event_start)

      # Create event start before event end
      good_params = %{
        event_start: now,
        event_end: DateTime.add(now, 100, :second)
      }

      # Changeset might still be invalid but at least not for this tests check
      assert %Changeset{errors: errors} = Event.new_event_changeset(%Event{}, good_params)
      refute Keyword.has_key?(errors, :event_start)
    end

    test ":sheet_open needs to be before :sheet_closed" do
      now = DateTime.utc_now()

      # Create event start after event end
      bad_params = %{
        sheet_open: now,
        sheet_closed: DateTime.add(now, -100, :second)
      }

      assert %Changeset{valid?: false, errors: errors} =
               Event.new_event_changeset(%Event{}, bad_params)

      assert Keyword.has_key?(errors, :event_start)

      # Create event start before event end
      good_params = %{
        event_start: now,
        event_end: DateTime.add(now, 100, :second)
      }

      # Changeset might still be invalid but at least not for this tests check
      assert %Changeset{errors: errors} = Event.new_event_changeset(%Event{}, good_params)
      refute Keyword.has_key?(errors, :event_start)
    end
  end
end
