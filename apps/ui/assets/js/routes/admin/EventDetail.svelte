<script>
  import EventForm from '@common/events/EventForm.svelte'
  export let event
</script>

<EventForm
  titleText="Edit Event"
  confirmButtonText="Update"
  {...event}
  />
