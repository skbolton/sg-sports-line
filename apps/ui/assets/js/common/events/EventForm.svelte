<script>
  import { createEventDispatcher } from 'svelte'
  import { format } from 'date-fns'
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

  // Break up dates into date and time elements for different form inputs
  const DATE_FORMAT = 'yyyy-MM-dd'
  const TIME_FORMAT = 'hh:mm'

  let eventStartDate = eventStart ? format(new Date(eventStart), DATE_FORMAT): ''
  let eventStartTime = eventStart ? format(new Date(eventStart), TIME_FORMAT) : ''

  let eventEndDate = eventEnd ? format(new Date(eventEnd), DATE_FORMAT) : ''
  let eventEndTime = eventEnd ? format(new Date(eventEnd), TIME_FORMAT) : ''

  let sheetOpenDate = sheetOpen ? format(new Date(sheetOpen), DATE_FORMAT) : ''
  let sheetOpenTime = sheetOpen ? format(new Date(sheetOpen), TIME_FORMAT) : ''

  let sheetClosedDate = sheetClosed ? format(new Date(sheetClosed), DATE_FORMAT) : ''
  let sheetClosedTime = sheetClosed ? format(new Date(sheetClosed), TIME_FORMAT) : ''

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
