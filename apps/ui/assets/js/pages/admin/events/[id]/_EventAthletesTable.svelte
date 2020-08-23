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
      dispatch('eventAthleteChanged', {id: selectedAthlete.id, cost: editedCost, winnings: editedWinnings})
    }
  }

  const onPendingAthleteSave = pendingAthlete => {
    dispatch('pendingAthleteSaved', pendingAthlete)
  }

</script>

<table class="table is-fullwidth is-hoverable is-bordered">
  <thead>
    <tr>
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
            <div class="field has-addons">
              <div class="control">
                <input class="input" type="text" bind:value={editedWinnings}>
              </div>
              <div class="control">
                <button class="button is-primary" disabled={!changes} on:click={onEventAthleteSave}>Save</button>
              </div>
              <div class="control">
                <a class="button is-light" on:click={onCancel}>Cancel</a>
              </div>
            </div>
          </td>
        </tr>
      {:else}
        <tr on:click={() => selectAthlete(ea)}>
          <td>{ea.athlete.name}</td>
          <td>{ea.cost}</td>
          <td>{ea.winnings}</td>
        </tr>
      {/if}
    {/each}
    {#each pendingAthletes as pending}
      <tr class="has-background-light">
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
          <div class="field">
            <div class="control">
              <button class="button is-primary" on:click={() => onPendingAthleteSave(pending)}>Add</button>
            </div>
          </div>
        </td>
      </tr>
    {/each}
  </tbody>
</table>
