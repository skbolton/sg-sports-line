<script>
  import api from '../../api'
  import Event from './Event.svelte'

  let events = api.events.all()
    .then(api.getData)
    .then(({ events }) => events)
</script>

{#await events}
  ...Loading
  {:then events}
    {#if events.length > 0}
      <div class="columns">
        {#each events as event}
          <div class="column is-one-third-desktop">
            <Event event={event}/>
          </div>
        {/each}
      </div>
    {:else}
      <h3>No events to show</h3>
    {/if}
  {:catch error}
    There was an issue loading events
{/await}
