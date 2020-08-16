<script>
  import api from '@api'
  import EventForm from '@common/events/EventForm.svelte'
  export let event

  let loading = false

  const updateEventQuery = `
    mutation updateEvent($id: ID!, $name: String, $eventStart: DateTime, $eventEnd: DateTime, $sheetOpen: DateTime, $sheetClosed: DateTime, $sheetCost: Int, $fundsGranted: Int) {
      updateEvent(id: $id, name: $name, eventStart: $eventStart, eventEnd: $eventEnd, sheetOpen: $sheetOpen, sheetClosed: $sheetClosed, sheetCost: $sheetCost, fundsGranted: $fundsGranted) {
          id
          name
          eventStart
          eventEnd
          sheetOpen
          sheetClosed
          sheetCost
          fundsGranted
        }
    }
  `

  const submit = ({ detail: event }) => {
    loading = true
    // loading is too fast!
    let prom = api.graph(updateEventQuery, {id: event.id, ...event.toJSON()})
    setTimeout(() => {
      prom.then(({ updateEvent }) => {
        event =  updateEvent
      })
        .finally(() => loading = false)
    }, 600)
  }
</script>

<EventForm
  titleText="Edit Event"
  confirmButtonText="Update"
  on:eventSubmitted={submit}
  {loading}
  event={event.clone()}
  />
