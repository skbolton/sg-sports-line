<script>
  import { isEqual, isDate, format } from 'date-fns'
  import { createEventDispatcher } from 'svelte'

  // properties
  export let datetime
  export let label

  /*
   * Break up the date into a date and a time so that we can render two inputs
   * The format needs to be correct for each html input to recognize the value.
   * It's also possible that no date was given to us and we are building for
   * the first time.
   */
  const DATE_FORMAT = 'yyyy-MM-dd'
  const TIME_FORMAT = 'kk:mm'

  let date = isDate(datetime) ? format(datetime, DATE_FORMAT) : ''
  let time = isDate(datetime) ? format(datetime, TIME_FORMAT) : ''

  const dispatch = createEventDispatcher()

  // only build new date if we have all the parts
  $: newDate = date && time && new Date(`${date}T${time}`)

  // if we end up with a new date broadcast it
  $: if (!isEqual(newDate, datetime)) {
    dispatch('dateChanged', { date: newDate })
  }
</script>

<label class="label">{label}</label>
<div class="field mb-5 is-grouped">
  <div class="control has-icons-left is-expanded">
    <input
      class="input"
      type="date"
      bind:value={date}
    />
    <span class="icon is-small is-left">
      <i class="ri-calendar-event-line"></i>
    </span>
  </div>
  <div class="control">
    <input
      class="input"
      type="time"
      bind:value={time}
    />
  </div>
</div>
