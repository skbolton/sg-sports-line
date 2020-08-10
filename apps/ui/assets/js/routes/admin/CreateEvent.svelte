<script>
  import {navigate} from 'svelte-routing'
  import api from '../../api'

  let name = ''
  let eventStartDate = ''
  let eventStartTime = '09:00:00'
  let eventEndDate = ''
  let eventEndTime = '17:00:00'
  let sheetOpenDate = ''
  let sheetOpenTime = '09:00:00'
  let sheetClosedDate = ''
  let sheetClosedTime = '17:00:00'
  let sheetCost = '20'
  let fundsGranted = '100'

  $: allFields = [name, eventStartDate, eventStartTime, eventEndDate, eventEndTime, sheetOpenDate, sheetOpenTime, sheetClosedDate, sheetClosedTime, sheetCost, fundsGranted]
  $: submittable = allFields.every(Boolean)

  const createEventMutation = `
    mutation createEvent($name: String! $eventStart: DateTime! $eventEnd: DateTime! $sheetOpen: DateTime! $sheetClosed: DateTime!) {
      createEvent(name: $name eventStart: $eventStart eventEnd: $eventEnd sheetOpen: $sheetOpen sheetClosed: $sheetClosed) {
        id
      }
    }
  `

  const create = () => {
    if (!submittable) {
      return
    }

    api.graph(createEventMutation, {
      name: name,
      eventStart: `${eventStartDate} ${eventStartTime}Z`,
      eventEnd: `${eventEndDate} ${eventEndTime}Z`,
      sheetOpen: `${sheetOpenDate} ${sheetOpenTime}Z`,
      sheetClosed: `${sheetClosedDate} ${sheetClosedTime}Z`,
      sheetCost: sheetCost,
      fundsGranted: fundsGranted
    })
      .then(console.log)
      .then(() => navigate("/admin"))
  }

</script>

<style>
  form {
    width: 100%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<section class="hero is-fullheight">
  <div class="hero-body aic jcc">
    <form class="box" on:submit|preventDefault={create}>
      <h1 class="title has-text-black">New Event</h1>

      <div class="field mb-5">
        <label class="label">Name</label>
        <div class="control has-icons-left">
          <input class="input" type="text" bind:value={name} placeholder="The Masters" on:keyup={event => name = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-flag-line"></i>
          </span>
        </div>
      </div>

      <label class="label">Event Start</label>
      <div class="field mb-5 is-grouped">
        <div class="control has-icons-left is-expanded">
          <input class="input" type="date" bind:value={eventStartDate} placeholder="Name" on:change={event => eventStartDate = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-calendar-event-line"></i>
          </span>
        </div>
        <div class="control">
          <input class="input" type="time" bind:value={eventStartTime} on:change={event => eventStartTime = event.target.value}>
        </div>
      </div>

      <label class="label">Event End</label>
      <div class="field mb-5 is-grouped">
        <div class="control has-icons-left is-expanded">
          <input class="input" type="date" bind:value={eventEndDate} on:change={event => eventEndDate = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-calendar-event-line"></i>
          </span>
        </div>
        <div class="control">
          <input class="input" type="time" bind:value={eventEndTime} on:change={event => eventEndTime = event.target.value}>
        </div>
      </div>

      <label class="label">Sheet Open</label>
      <div class="field mb-5 is-grouped">
        <div class="control has-icons-left is-expanded">
          <input class="input" type="date" bind:value={sheetOpenDate} placeholder="Name" on:change={event => sheetOpenDate = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-door-open-line"></i>
          </span>
        </div>
        <div class="control">
          <input class="input" type="time" bind:value={sheetOpenTime} on:change={event => sheetOpenTime = event.target.value}>
        </div>
      </div>

      <label class="label">Sheet Close</label>
      <div class="field mb-5 is-grouped">
        <div class="control has-icons-left is-expanded">
          <input class="input" type="date" bind:value={sheetClosedDate} placeholder="Name" on:change={event => sheetClosedDate = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-door-closed-line"></i>
          </span>
        </div>
        <div class="control">
          <input class="input" type="time" bind:value={sheetClosedTime} on:change={event => sheetClosedTime = event.target.value}>
        </div>
      </div>

      <label class="label">Sheet Cost</label>
      <div class="field mb-5">
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
          <input type="submit" disabled={!submittable} value="Create" class="button is-primary mr-4">
          <input type="submit" value="Cancel" class="button is-light" on:click={() => navigate("/admin")}>
        </div>
      </div>
    </form>
  </div>
</section>
