<script>
  import { createEventDispatcher } from 'svelte'
  import EventListItem from './EventListItem.svelte'
  export let events

  const dispatch = createEventDispatcher()
</script>

<div class="columns">
  {#each events as event}
    <div class="column is-half-desktop">
      <EventListItem on:click={() => dispatch('eventClicked', event)} event={event}/>
    </div>
  {/each}
</div>
