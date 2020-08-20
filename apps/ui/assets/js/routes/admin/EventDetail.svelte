<script>
  import api from '@api'
  import EventForm from '@common/events/EventForm.svelte'
  import event from '@stores/event'

  let eventDetails = $event.event
</script>

<EventForm
  titleText="Edit Event"
  confirmButtonText="Update"
  on:eventSubmitted={({ detail }) => event.updateDetails(detail)}
  on:eventCancelled={() => eventDetails = $event.event}
  on
  loading={$event.loading}
  event={eventDetails.clone()}
/>
