<script>
  import api from '@api'
  export let event

  let searchResults = []
  let searchText = ''

  const searchAthletesQuery = `
    query athleteSearch($search: String!) {
      athleteByName(search: $search, fuzzy: true) {
        id
        name
      }
    }
  `

  const addAthleteQuery = `
    mutation addAthlete($eventId: ID!, $athleteId: ID!) {
      add_athlete_to_event(athleteId: $athleteId, eventId: $eventId, cost: 50) {
        name
      }
    }
  `

  const onAthleteSelect = (id) => {
    searchResults = []
    searchText = ''
    api.graph(addAthleteQuery, { eventId: event.id, athleteId: id }).then(console.log)
  }

  const search = ({ target }) => {
    api.graph(searchAthletesQuery, {search: target.value}).then(({ athleteByName }) => {
      searchResults = athleteByName
    })
  }
</script>

<form on:submit|preventDefault>
  <div class="field">
    <div class="control has-icons-left">
      <span class="icon is-small is-left"><i class="ri-search-line"></i></span>
      <input class="input" type="text" bind:value={searchText} placeholder="Search Athletes" on:change={search}>
    </div>
  </div>
</form>

{#if searchResults.length}
  <div class="panel">
    {#each searchResults as result}
      <a class="panel-block" on:click={() => onAthleteSelect(result.id)}>
        {result.name}
      </a>
    {/each}
  </div>
{/if}
