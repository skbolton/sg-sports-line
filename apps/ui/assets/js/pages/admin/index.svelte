<script>
  import { url, goto } from '@sveltech/routify'
  import api from '@api'
  import EventList from '@common/events/EventList.svelte'

  const adminEventsQuery = `
    query {
      allEvents {
        name
        id
        eventStart
        eventEnd
      }
    }
  `

  const allEvents = api.graph(adminEventsQuery)
    .then(({ allEvents }) => allEvents)

  const goToEvent = ({ detail })  => {
    if (detail.id) {
      return $goto(`/admin/events/${detail.id}/details`)
    }
  }

</script>

<style>
  .event-container {
    padding: 0px 32px;
    max-width: 1000px;
    margin: 0 auto;
  }

  button {
    position: absolute;
    bottom: 32px;
    right: 32px;
    border-radius: 50%;
  }
</style>

<div class="event-container">
  <h1 class="title">Events</h1>
  {#await allEvents}
    Loading...
    {:then events}
      <EventList events={events} on:eventClicked={goToEvent} />
  {/await}
</div>
<a href={$url('/admin/events/create')}>
  <button class="button is-primary is-size-4">+</button>
</a>
