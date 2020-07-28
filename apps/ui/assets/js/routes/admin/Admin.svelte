<script>
  import { Router, Route } from 'svelte-routing'
  import Events from './Events.svelte'
  import Login from './Login.svelte'
  import CreateEvent from './CreateEvent.svelte'
</script>

<Router url="">
  <Route path="login" component="{Login}"></Route>
  <Route path="create-event" component="{CreateEvent}"></Route>
  <Route component="{Events}" />
</Router>
