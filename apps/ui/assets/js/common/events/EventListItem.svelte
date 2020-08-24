<script>
  import { format, formatDistance } from 'date-fns'
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
      <div class="tags has-addons">
        <span class="tag is-primary">{formatDistance(new Date(event.eventStart), new Date())}</span>
        <span class="tag is-light">{format(new Date(event.eventStart), 'cccc - LLL do yyyy')}</span>
      </div>
      <p class="event-item-heading">
        Event End
      </p>
      <div class="tags has-addons">
        <span class="tag is-primary">{formatDistance(new Date(event.eventEnd), new Date())}</span>
        <span class="tag is-light">{format(new Date(event.eventEnd), 'cccc - LLL do yyyy')}</span>
      </div>
    </main>
  </section>
</div>
