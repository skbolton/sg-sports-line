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
</style>

<div class="event-container">
  <div class="level">
    <div class="level-left">
      <div class="level-item">
        <h1 class="title">Events</h1>
      </div>
    </div>
    <div class="level-right">
      <div class="level-item">
        <a href={$url("/admin/events/create")} class="button is-link">
          <i class="ri-flag-line"></i>&nbsp;
          New Event
        </a>
      </div>
    </div>
  </div>
  {#await allEvents}
    Loading...
    {:then events}
      <EventList events={events} on:eventClicked={goToEvent} />
  {/await}
</div>
