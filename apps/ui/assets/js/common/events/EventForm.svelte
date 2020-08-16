<script>
  import { createEventDispatcher } from 'svelte'
  import { format, set } from 'date-fns'
  import EventDate from './EventDate.svelte'
  // ui properties
  export let titleText = 'Event'
  export let confirmButtonText = 'Go'
  export let cancelButtonText = 'Cancel'
  export let loading
  export let event

  const dispatch = createEventDispatcher()

  $: submittable = event.validate().valid

  const submitted = () => {
    if (!submittable) {
      return
    }

    dispatch(
      'eventSubmitted',
      event
    )
  }
</script>

<form class="box" on:submit|preventDefault={submitted}>
  <h1 class="title has-text-black">{titleText}</h1>

  <label class="label">Name</label>
  <div class="field mb-5">
    <div class="control has-icons-left">
      <input class="input" type="text" value={event.name} placeholder="The Masters" on:keyup={({ target }) => event.name = target.value}>
      <span class="icon is-small is-left">
        <i class="ri-flag-line"></i>
      </span>
    </div>
  </div>

  <EventDate label="Event Start" datetime={event.eventStart} on:dateChanged={({ detail }) => event.eventStart = detail.date}/>
  <EventDate label="Event End" datetime={event.eventEnd} on:dateChanged={({ detail }) => event.eventEnd = detail.date}/>
  <EventDate label="Sheet Open" datetime={event.sheetOpen} on:dateChanged={({ detail }) => event.sheetOpen = detail.date}/>
  <EventDate label="Sheet Closed" datetime={event.sheetClosed} on:dateChanged={({ detail }) => event.sheetClosed = detail.date}/>

  <label class="label">Sheet Cost</label>
  <div class="field mb-5">
    <div class="control has-icons-left">
      <input class="input" type="text" value={event.sheetCost} placeholder="20" on:keypress={({ target }) => event.sheetCost = target.value}>
      <span class="icon is-small is-left">
        <i class="ri-currency-line"></i>
      </span>
    </div>
  </div>

  <div class="field mb-5">
    <label class="label">Funds Granted</label>
    <div class="control has-icons-left">
      <input class="input" type="text" value={event.fundsGranted} placeholder="100" on:keypress={({ target }) => event.fundsGranted = target.value}>
      <span class="icon is-small is-left">
        <i class="ri-bank-card-line"></i>
      </span>
    </div>
  </div>

  <div class="field mb-5">
    <div class="control">
      <button type="submit" disabled={!submittable} class="button is-primary mr-4" class:is-loading={loading}>{confirmButtonText}</button>
      <input type="submit" value={cancelButtonText} class="button is-light" on:click={() => dispatch('eventCancelled')}>
    </div>
  </div>
</form>
