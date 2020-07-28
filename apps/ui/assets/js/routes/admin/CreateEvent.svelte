<script>
  import {navigate} from 'svelte-routing'

  let name = ''
  let eventStart = ''
  let eventEnd = ''
  let sheetOpen = ''
  let sheetClosed = ''
  let sheetCost = '20'
  let fundsGranted = '100'

  let allFields = [name, eventStart, eventEnd, sheetOpen, sheetClosed, sheetCost, fundsGranted]

  $: submittable = allFields.every(Boolean)
</script>

<style>
  form {
    width: 100%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<section class="hero is-link is-fullheight">
  <div class="hero-body aic jcc">
    <form class="box" on:submit|preventDefault={login}>
      <h1 class="title has-text-black">New Event</h1>

      <div class="field mb-5">
        <label class="label">Name</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={name} placeholder="Name" on:keypress={event => name = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-flag-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Event Start</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={eventStart} placeholder="Name" on:keypress={event => eventStart = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-calendar-event-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Event End</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={eventEnd} placeholder="Name" on:keypress={event => eventEnd = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-calendar-event-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Sheet Open</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={sheetOpen} placeholder="Name" on:keypress={event => sheetOpen = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-door-open-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Sheet Close</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={sheetClosed} placeholder="Name" on:keypress={event => sheetClosed = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-door-closed-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Sheet Cost</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={sheetCost} placeholder="20" on:keypress={event => sheetCost = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-currency-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <label class="label">Funds Granted</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={fundsGranted} placeholder="100" on:keypress={event => fundsGranted = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-bank-card-line"></i>
          </span>
        </div>
      </div>

      <div class="field mb-5">
        <div class="control">
          <input type="submit" disabled={!submittable} value="Create" class="button is-link mr-4">
          <input type="submit" value="Cancel" class="button is-light" on:click={() => navigate("/admin")}>
        </div>
      </div>
    </form>
  </div>
</section>
