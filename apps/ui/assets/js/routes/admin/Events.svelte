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
  button {
    position: absolute;
    bottom: 25px;
    right: 25px;
    border-radius: 50%;
  }
</style>

<Navbar/>
<div class="container">
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
