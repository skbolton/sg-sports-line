<script>
  export let event
</script>

<div class="card">
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
