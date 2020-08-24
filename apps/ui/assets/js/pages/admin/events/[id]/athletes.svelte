<script>
  import api from '@api'
  import CreateAthlete from '@common/CreateAthlete.svelte'
  import eventAthletes from '@stores/eventAthletes'
  import athlete from '@stores/athlete'
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

  const athleteCreated = ({ detail }) => {
    // we now have a new athlete we can go and fetch
    athlete.createAthlete(detail.name)
      .then(() => eventAthletes.getAthletes(event.id))
  }
</script>

{#await prom}
  {:then result}
    <EventAthletesTable
      eventAthletes={$eventAthletes.eventAthletes}
      pendingAthletes={$eventAthletes.pendingAthletes}
      on:eventAthleteChanged={({ detail }) => eventAthletes.updateAthlete({ id: detail.id, cost: detail.cost, winnings: detail.cost })}
      on:pendingAthleteSaved={({ detail }) => eventAthletes.addAthlete({athleteId: detail.id, eventId: event.id, cost: detail.cost, winnings: 0})}
    />
    <hr>
    
    <AvailableAthletesTable
      availableAthletes={$eventAthletes.availableAthletes}
      on:selectedAthletesSubmitted={availableAthletesSelected}
    />

    <CreateAthlete on:athleteCreate={athleteCreated}/>
{/await}


