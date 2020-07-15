<script>
  import { Router, Route } from 'svelte-routing'
  import Events from './Events.svelte'
  import Login from './Login.svelte'
</script>

<Router>
  <Route component="{Login}"></Route>
  <Route path="/" component="{Events}" />
</Router>
