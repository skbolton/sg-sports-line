<script>
  import { createEventDispatcher } from 'svelte'
  // ui props
  export let availableAthletes = []

  const dispatch = createEventDispatcher()

  let selectedAthletes = []

  const toggleSelectAthelte = athlete => {
    const index = selectedAthletes.findIndex(selected => selected.id === athlete.id)

    selectedAthletes = index >= 0
      ? [...selectedAthletes.slice(0, index), ...selectedAthletes.slice(index + 1)]
      : [...selectedAthletes, athlete]
  }

  const submitSelectedAthletes = () => {
    dispatch('selectedAthletesSubmitted', { selectedAthletes })
    selectedAthletes = []
  }
</script>

<h2 class="title is-4">Available Athletes</h2>
<div class="card mb-5">
  <div class="card-content">
    <div class="level">
      <div class="level-left">
        <div class="level-item">
          <p>{selectedAthletes.length} selected</p>
        </div>
      </div>
      <div class="level-right">
        <div class="level item">
          <button disabled={selectedAthletes.length === 0} class="button is-primary" on:click={submitSelectedAthletes}>
            <i class="ri-add-line"></i>
            <span>Add Selected</span>
          </button>
        </div>
      </div>
    </div>
    <div class="columns is-multiline is-gapless">
      {#each availableAthletes as athlete}
        <div class="column is-4">
          <label class="label">
            <input class="checkbox mr-2" type="checkbox" checked={selectedAthletes.includes(athlete)} on:change={() => toggleSelectAthelte(athlete)}>
            {athlete.name}
          </label>
        </div>
      {/each}
    </div>
  </div>
</div>
