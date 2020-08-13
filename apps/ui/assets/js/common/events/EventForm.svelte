<script>
  import { createEventDispatcher } from 'svelte'
  // ui properties
  export let titleText = 'Event'
  export let confirmButtonText = 'Go'
  export let cancelButtonText = 'Cancel'

  // event fields
  export let name = ''
  export let eventStart = ''
  export let eventEnd = ''
  export let sheetOpen = ''
  export let sheetClosed = ''
  export let sheetCost = '20'
  export let fundsGranted = '100'


  let eventStartDate = eventStart ? `${new Date(eventStart).getFullYear()}-${new Date(eventStart).getMonth() + 1}-${new Date(eventStart).getDate()}` : '';
  let eventStartTime = eventStart ? `${(new Date(eventStart).getHours()).toString().padStart(2, '0')}:${(new Date(eventStart).getMinutes()).toString().padStart(2, '0')}` : '';
  let eventEndDate = eventEnd ? `${new Date(eventEnd).getFullYear()}-${new Date(eventEnd).getMonth() + 1}-${new Date(eventEnd).getDate()}` : '';
  let eventEndTime = eventEnd ? `${(new Date(eventEnd).getHours()).toString().padStart(2, '0')}:${(new Date(eventEnd).getMinutes()).toString().padStart(2, '0')}` : '';
  let sheetOpenDate =  sheetOpen ? `${new Date(sheetOpen).getFullYear()}-${new Date(sheetOpen).getMonth() + 1}-${new Date(sheetOpen).getDate()}` : '';
  let sheetOpenTime = sheetOpen ? `${(new Date(sheetOpen).getHours()).toString().padStart(2, '0')}:${(new Date(sheetOpen).getMinutes()).toString().padStart(2, '0')}` : '';
  let sheetClosedDate = sheetClosed ? `${new Date(sheetClosed).getFullYear()}-${new Date(sheetClosed).getMonth() + 1}-${new Date(sheetClosed).getDate()}` : '';
  let sheetClosedTime = sheetClosed ? `${(new Date(sheetClosed).getHours()).toString().padStart(2, '0')}:${(new Date(sheetClosed).getMinutes()).toString().padStart(2, '0')}` : '';

  const dispatch = createEventDispatcher()

  $: allFields = [name, eventStartDate, eventStartTime, eventEndDate, eventEndTime, sheetOpenDate, sheetOpenTime, sheetClosedDate, sheetClosedTime, sheetCost, fundsGranted]
  $: submittable = allFields.every(Boolean)

  const submitted = () => {
    if (!submittable) {
      return
    }

    dispatch(
      'eventSubmitted',
      {
        name,
        eventStart: new Date(`${eventStartDate} ${eventStartTime}`).toJSON(),
        eventEnd: new Date(`${eventEndDate} ${eventEndTime}`).toJSON(),
        sheetOpen: new Date(`${sheetOpenDate} ${sheetOpenTime}`).toJSON(),
        sheetClosed: new Date(`${sheetClosedDate} ${sheetClosedTime}`).toJSON(),
        sheetCost,
        fundsGranted
      }
    )
  }
</script>

<form class="box" on:submit|preventDefault={submitted}>
  <h1 class="title has-text-black">{titleText}</h1>

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
      <input class="input" type="date" bind:value={eventStartDate} placeholder="Name" on:change={event => eventStart = event.target.value}>
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
      <input type="submit" disabled={!submittable} value={confirmButtonText} class="button is-primary mr-4">
      <input type="submit" value={cancelButtonText} class="button is-light" on:click={() => dispatch('eventCancelled')}>
    </div>
  </div>
</form>
