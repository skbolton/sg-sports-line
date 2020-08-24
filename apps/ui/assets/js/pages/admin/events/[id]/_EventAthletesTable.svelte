<script>
  import { createEventDispatcher } from 'svelte'
  export let eventAthletes = []
  export let pendingAthletes = []

  const dispatch = createEventDispatcher()

  let selectedAthlete = null
  let editedCost = null
  let editedWinnings = null

  const selectAthlete = athlete => {
    selectedAthlete = athlete
    editedCost = athlete.cost
    editedWinnings = athlete.winnings
  }

  $: changes = (selectedAthlete
    && (selectedAthlete.cost !== editedCost || selectedAthlete.winnings !== editedWinnings))

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
      <th>Id</th>
      <th>Name</th>
      <th>Cost</th>
      <th>Winnings</th>
    </tr>
  </thead>
  <tbody>
    {#each eventAthletes as ea}
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
