<script>
  import api from '@api'
  import Navbar from '@common/Nav.svelte'
  import EventTabBar from './EventTabBar.svelte'
  import EventDetail from './EventDetail.svelte'
  export let id
  export let page 

  const eventQuery = `
    query eventById($id: ID!) {
      event(id: $id) {
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

  const event = api.graph(eventQuery, { id }).then(({ event }) => event)

</script>

<style>
  .event-container {
    padding: 0px 32px;
    max-width: 1000px;
    margin: 0 auto;
  }
</style>

<Navbar url="/admin"/>

<div class="event-container">
  {#await event}
    Loading...
    {:then event}
      <h1 class="title">{event.name}</h1>
      <EventTabBar id={id} page={page}></EventTabBar>
      {#if page === 'details'}
        <EventDetail event={event}/>
      {/if}
  {/await}
</div>
