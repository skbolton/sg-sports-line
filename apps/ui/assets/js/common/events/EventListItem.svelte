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

<div class="card">
  <section class="card-content">
    <main class="content">
      <div class="level">
        <div class="level-left">
          <div class="level-item">
            <h1 class="title is-4">{event.name}</h1>
          </div>
        </div>
        <div class="level-right">
          <div class="level-item" on:click>
            <span class="icon"><i class="is-size-5 ri-edit-box-line"></i></span>
          </div>
        </div>
      </div>
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
