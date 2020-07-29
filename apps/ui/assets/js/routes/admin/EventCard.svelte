<script>
  import {navigate} from 'svelte-routing'
  export let event

</script>

<div class="card" on:click={() => navigate(`/admin/event/${event.id}`)}>
  <section class="card-content">
    <main class="content">
      <h1 class="title is-4">{event.name}</h1>
      <p>
        <strong>Event Start</strong>
      </p>
      <p>{new Date(event.event_start).toDateString()}

      <p>
        <strong>Event End</strong>
      </p>
      <p>{new Date(event.event_end).toDateString()}
    </main>
  </section>
</div>
