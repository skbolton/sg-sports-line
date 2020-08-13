<script>
  import {navigate} from 'svelte-routing'
  import api from '../../api'
  import EventForm from '@common/events/EventForm.svelte'

  const createEventMutation = `
    mutation createEvent($name: String! $eventStart: DateTime! $eventEnd: DateTime! $sheetOpen: DateTime! $sheetClosed: DateTime!) {
      createEvent(name: $name eventStart: $eventStart eventEnd: $eventEnd sheetOpen: $sheetOpen sheetClosed: $sheetClosed) {
        id
      }
    }
  `

  const create = ({ detail }) =>
    api.graph(createEventMutation, detail)
      .then(console.log)
      .then(() => navigate("/admin"))

</script>

<style>
  .container {
    width: 100%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<section class="hero is-fullheight">
  <div class="hero-body aic jcc">
    <div class="container">
      <EventForm titleText="New Event" confirmButtonText="Create" eon:eventSubmitted={create} on:eventCancelled={() => navigate("/admin")}/>
    </div>
  </div>
</section>
