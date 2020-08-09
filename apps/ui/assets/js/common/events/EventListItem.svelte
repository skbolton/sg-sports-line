<script>
  export let event = {}
</script>

<div class="card" on:click>
  <section class="card-content">
    <main class="content">
      <h1 class="title is-4">{event.name}</h1>
      <p>
        <strong>Event Start</strong>
      </p>
      <p>{new Date(event.eventStart).toDateString()}

      <p>
        <strong>Event End</strong>
      </p>
      <p>{new Date(event.eventEnd).toDateString()}
    </main>
  </section>
</div>
