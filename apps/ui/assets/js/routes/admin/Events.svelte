<script>
  import {Link} from 'svelte-routing'
  import api from '@api'
  import Navbar from '@common/Nav.svelte'
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

<Navbar/>
<div class="event-container">
  <h1 class="title">Events</h1>
  {#await allEvents}
    Loading...
    {:then events}
      <EventList events={events} on:eventClicked={console.log} />
  {/await}
</div>
<Link to="create-event">
  <button class="button is-primary is-size-4">+</button>
</Link>
