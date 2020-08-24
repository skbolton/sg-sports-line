<script>
  import { goto } from '@sveltech/routify'
  /* import Event from './models/events/event.js' */
  import Event from '../../../models/events/event.js'
  import api from '@api'
  import EventForm from '@common/events/EventForm.svelte'

  const event = new Event({ name: '' })

  const createEventMutation = `
    mutation createEvent($input: CreateEventInput) {
      createEvent(input: $input) {
        __typename
        ... on Event {
          id
        }
        ... on InvalidParams {
          fields
          errors
        }
      }
    }
  `

  const create = ({ detail }) =>
    api.graph(createEventMutation, {input: detail.toJSON()})
      .then(console.log)
      .then(() => $goto("/admin/"))

</script>

<style>
  .container {
    width: 100%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<div class="container">
  <EventForm event={event} titleText="New Event" confirmButtonText="Create" on:eventSubmitted={create} on:eventCancelled={() => $goto("/admin/")}/>
</div>
