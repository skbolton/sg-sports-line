<script>
  import { createEventDispatcher } from 'svelte'

  const dispatch = createEventDispatcher()

  let athleteName = ""

  const onCreate = () => {
    dispatch('athleteCreate', { name: athleteName })
    athleteName = ""
  }

</script>

<h1 class="title is-4">Create Athlete</h1>
<div class="card">
  <div class="card-content">
    <div class="field is-grouped">
      <div class="control is-expanded">
        <input
          bind:value={athleteName}
          type="text"
          class="input"
          placeholder="Athlete Name">
      </div>
      <div class="control">
        <button class="button is-primary" disabled={!athleteName} on:click={onCreate}>
          <i class="ri-add-line"></i>
          <span>Create Athlete</span>
        </button>
      </div>
    </div>
  </div>
</div>
