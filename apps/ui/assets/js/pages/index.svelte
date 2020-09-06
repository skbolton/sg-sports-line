<script>
  import { url, goto } from '@sveltech/routify'
  import api from '@api'
  import EventList from '@common/events/EventList.svelte'

  const activeEvents = `
    query {
      activeEvents {
        name
        id
        eventStart
        eventEnd
      }
    }
  `

  const allEvents = api.graph(activeEvents)
    .then(({ activeEvents }) => activeEvents)

  const goToEvent = ({ detail })  => {
    if (detail.id) {
      return $goto(`/events/${detail.id}`)
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
        <h1 class="title">Active Events</h1>
      </div>
    </div>
  </div>
  {#await allEvents}
    Loading...
    {:then events}
      {#if events.length === 0}
        <p>No events at this time. Check back later.</p>
      {:else}
        <EventList events={events} on:eventClicked={goToEvent} />
      {/if}
  {/await}
</div>
