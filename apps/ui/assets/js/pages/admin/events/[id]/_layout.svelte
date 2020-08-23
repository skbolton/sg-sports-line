<script>
  import { onMount } from 'svelte'
  import EventTabBar from './_EventTabBar.svelte'
  import event from '@stores/event'

  export let id
  export let page 

  onMount(() => event.getById(id))

</script>

<style>
  .event-container {
    padding: 0px 32px;
    max-width: 1000px;
    margin: 0 auto;
  }
</style>

<div class="event-container">
  {#if $event.loading}
    Loading...
  {:else if $event.event}
    <h1 class="title">{$event.event.name}</h1>
    <EventTabBar id={id}></EventTabBar>
    <slot scoped={{event: $event.event}}></slot>
  {/if}
</div>
