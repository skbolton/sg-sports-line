<script>
  import { createEventDispatcher } from 'svelte'
  export let eventAthletes = []
  export let pendingAthletes = []

  const dispatch = createEventDispatcher()

  let sortBy = "name"
  let direction = "asc"
  $: sortedAthletes = eventAthletes.slice()
  let selectedAthlete = null
  let editedCost = null
  let editedWinnings = null

  const selectAthlete = athlete => {
    selectedAthlete = athlete
    editedCost = athlete.cost
    editedWinnings = athlete.winnings
  }

  $: if (sortBy === "name") {
    sortedAthletes = sortedAthletes.sort((a, b) => direction === "asc" ? a.athlete.name > b.athlete.name : a.athlete.name < b.athlete.name)

   } else {
     sortedAthletes = sortedAthletes.sort((a, b) => direction === "asc" ? a[sortBy] > b[sortBy] : a[sortBy] < b[sortBy])
  }

  $: changes = (selectedAthlete
    && (selectedAthlete.cost !== editedCost || selectedAthlete.winnings !== editedWinnings))

  const changeSort = header => {
    if (sortBy === header) {
      direction = direction === "asc" ? "desc" : "asc"
      return
    }

    sortBy = header
    direction = "asc"
  }

  const onCancel = () => {
    selectedAthlete = null
    editedCost = null
    editedWinnings = null
  }

  const onEventAthleteSave = () => {
    if (changes) {
      dispatch(
        'eventAthleteChanged',
        {
          id: selectedAthlete.id,
          cost: parseInt(editedCost),
          winnings: parseInt(editedWinnings)
        }
      )
      onCancel()
    }
  }

  const onEventAthleteDelete = athlete => {
    dispatch(
      'eventAthleteDeleted',
      {
        id: athlete.id
      }
    )
  }

  const onPendingAthleteSave = pendingAthlete => {
    dispatch(
      'pendingAthleteSaved',
      {
        id: pendingAthlete.id,
        cost: parseInt(pendingAthlete.cost)
      }
    )
  }

</script>

<table class="table is-fullwidth is-hoverable is-bordered">
  <thead>
    <tr>
      <th on:click={() => changeSort('id')}>
        Id
        <span class="icon has-text-link">
          {#if sortBy === 'id'}
            {#if direction === 'asc'}
              <i class="ri-arrow-down-line"></i>
            {:else}
              <i class="ri-arrow-up-line"></i>
            {/if}
          {/if}
        </span>
      </th>
      <th on:click={() => changeSort('name')}>
        Name
        <span class="icon has-text-link">
          {#if sortBy === 'name'}
            {#if direction === 'asc'}
              <i class="ri-arrow-down-line"></i>
            {:else}
              <i class="ri-arrow-up-line"></i>
            {/if}
          {/if}
        </span>
      </th>
      <th on:click={() => changeSort('cost')}>
        Cost
        <span class="icon has-text-link">
          {#if sortBy === 'cost'}
            {#if direction === 'asc'}
              <i class="ri-arrow-down-line"></i>
            {:else}
              <i class="ri-arrow-up-line"></i>
            {/if}
          {/if}
        </span>
      </th>
      <th on:click={() => changeSort('winnings')}>
        Winnings
        <span class="icon has-text-link">
          {#if sortBy === 'winnings'}
            {#if direction === 'asc'}
              <i class="ri-arrow-down-line"></i>
            {:else}
              <i class="ri-arrow-up-line"></i>
            {/if}
          {/if}
        </span>
      </th>
    </tr>
  </thead>
  <tbody>
    {#each sortedAthletes as ea}
      {#if selectedAthlete && ea.id === selectedAthlete.id}
        <tr>
          <td>
            <div class="field has-addons">
              <div class="control">
                <a class="button is-danger" on:click={() => onEventAthleteDelete(ea)}>
                  <i class="ri-delete-bin-line"></i>
                </a>
              </div>
              <div class="control">
                <button class="button is-primary" disabled={!changes} on:click={onEventAthleteSave}><i class="ri-save-line"></i></button>
              </div>
              <div class="control">
                <a class="button is-light" on:click={onCancel}><i class="ri-close-line"></i></a>
              </div>
            </div>
          </td>
          <td>
            {ea.athlete.name}
          </td>
          <td>
            <div class="field">
              <div class="control">
                <input class="input" type="text" bind:value={editedCost}>
              </div>
            </div>
          </td>
          <td>
            <div class="field">
              <div class="control">
                <input class="input" type="text" bind:value={editedWinnings}>
              </div>
            </div>
          </td>
        </tr>
      {:else}
        <tr on:click={() => selectAthlete(ea)}>
          <td>{ea.id}</td>
          <td>{ea.athlete.name}</td>
          <td>{ea.cost}</td>
          <td>{ea.winnings}</td>
        </tr>
      {/if}
    {/each}
    {#each pendingAthletes as pending}
      <tr class="has-background-light">
        <td>
          <div class="field">
            <div class="control">
              <button class="button is-primary" on:click={() => onPendingAthleteSave(pending)}>Add</button>
            </div>
          </div>
        </td>
        <td>
          {pending.name}
        </td>
        <td>
          <div class="field">
            <div class="control">
              <input class="input" type="text" bind:value={pending.cost}>
            </div>
          </div>
        </td>
        <td>
          N/A
        </td>
      </tr>
    {/each}
  </tbody>
</table>
