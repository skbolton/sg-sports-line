<script>
  import api from '@api'
  import eventAthletes from '@stores/eventAthletes'
  import EventAthletesTable from './_EventAthletesTable.svelte'
  import AvailableAthletesTable from './_AvailableAthletesTable.svelte'
  export let scoped

  // properties
  let event = scoped.event

  const prom = eventAthletes.getAthletes(event.id)

  // events
  const onAthleteSelect = ({ id, name }) => {
    athleteSearch.clearSearch()
    searchText = ''
    pendingAthletes = [...pendingAthletes, { id, name, cost: 0, winnings: 0 }]
  }

  const availableAthletesSelected = ({ detail }) => {
    const { selectedAthletes = [] } = detail
    selectedAthletes.forEach(eventAthletes.selectAthleteToAdd)
  }
</script>

{#await prom}
  {:then result}
    <EventAthletesTable
      eventAthletes={$eventAthletes.eventAthletes}
      pendingAthletes={$eventAthletes.pendingAthletes}
      on:eventAthleteChanged={({ detail }) => eventAthletes.updateAthlete({ id: detail.id, cost: detail.cost, winnings: detail.cost })}
      on:pendingAthleteSaved={({ detail }) => console.log(detail)}
    />
    <hr>
    
    <AvailableAthletesTable
      availableAthletes={$eventAthletes.availableAthletes}
      on:selectedAthletesSubmitted={availableAthletesSelected}
    />
{/await}


