<script>
  export let event = {}
</script>

<style>
  p.event-item-heading {
    margin-bottom: 8px;
    font-weight: bold;
  }
</style>

<div class="card" on:click>
  <section class="card-content">
    <main class="content">
      <h1 class="title is-4">{event.name}</h1>
      <p class="event-item-heading">
        Event Start
      </p>
      <p>{new Date(event.eventStart).toDateString()}

      <p class="event-item-heading">
        Event End
      </p>
      <p>{new Date(event.eventEnd).toDateString()}
    </main>
  </section>
</div>
