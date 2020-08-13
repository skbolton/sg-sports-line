<script>
  import { Router, Route } from 'svelte-routing'
  import Events from './Events.svelte'
  import Login from './Login.svelte'
  import CreateEvent from './CreateEvent.svelte'
  import Event from './Event.svelte'
</script>

<Router url="">
  <Route path="login" component="{Login}"></Route>
  <Route path="create-event" component="{CreateEvent}"></Route>
  <Route path="event/:id/:tab" let:params>
    <Event id="{params.id}" page="{params.tab}"></Event>
  </Route>
  <Route component="{Events}" />
</Router>
