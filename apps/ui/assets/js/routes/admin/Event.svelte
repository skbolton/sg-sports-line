<script>
  import { onMount } from 'svelte'
  import Navbar from '@common/Nav.svelte'
  import EventTabBar from './EventTabBar.svelte'
  import EventDetail from './EventDetail.svelte'
  import EventAthletes from './EventAthletes.svelte'
  import event from '@stores/event'

  export let id
  export let page 

  onMount(() => event.getById(id))

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
  {#if $event.loading}
    Loading...
  {:else if $event.event}
    <h1 class="title">{$event.event.name}</h1>
    <EventTabBar id={id} page={page}></EventTabBar>
    {#if page === 'details'}
      <EventDetail event={$event.event}/>
    {:else if page === 'athletes'}
      <EventAthletes event={$event.event}/>
    {/if}
  {/if}
</div>
