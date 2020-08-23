<script>
  import { onMount } from 'svelte'
  import api from '@api'
  import eventAthletes from '@stores/eventAthletes'
  import athleteSearch from '@stores/athleteSearch'
  import EventAthletesTable from './_EventAthletesTable.svelte'
  export let scoped

  // properties
  let event = scoped.event

  // hooks
  onMount(() => eventAthletes.getAthletes(event.id))

  // ui state
  let pendingAthletes = []
  let searchText = ''

  // events
  const onAthleteSelect = ({ id, name }) => {
    athleteSearch.clearSearch()
    searchText = ''
    pendingAthletes = [...pendingAthletes, { id, name, cost: 0, winnings: 0 }]
  }
</script>

{#if $eventAthletes.eventAthletes}
  <EventAthletesTable
    eventAthletes={$eventAthletes.eventAthletes}
    pendingAthletes={pendingAthletes}
    on:eventAthleteChanged={({ detail }) => console.log(detail)}
    on:pendingAthleteSaved={({ detail }) => console.log(detail)}
  />
{:else}
  This event has no athletes yet
{/if}

<form on:submit|preventDefault>
  <div class="field">
    <div class="control has-icons-left">
      <span class="icon is-small is-left"><i class="ri-search-line"></i></span>
      <input
        class="input"
        type="text"
        bind:value={searchText}
        placeholder="Search Athletes"
        on:change={() => athleteSearch.search(searchText)}
      />
    </div>
  </div>
</form>

{#if $athleteSearch.results.length}
  <div class="panel">
    {#each $athleteSearch.results as result}
      {#if $eventAthletes.eventAthletes.some(eventAthlete => eventAthlete.athlete.name == result.name)}
        <a class="panel-block">
          <span class="panel-icon">
            <i class="ri-check-line"></i>
          </span>
          {result.name}
        </a>
      {:else}
        <a class="panel-block" on:click={() => onAthleteSelect(result)}>
          {result.name}
        </a>
      {/if}
    {/each}
  </div>
{/if}
