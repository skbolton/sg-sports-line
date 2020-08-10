<script>
  import { Router, Route } from 'svelte-routing'
  import Events from './Events.svelte'
  import Login from './Login.svelte'
  import CreateEvent from './CreateEvent.svelte'
  /* import Event from './Event.svelte' */
  /* <Route path="create-event" component="{CreateEvent}"></Route> */
    /* <Route path="/event/:id" let:params> */
    /*   <Event id="{params.id}"/> */
    /* </Route> */
</script>

<Router url="">
  <Route path="login" component="{Login}"></Route>
  <Route component="{Events}" />
</Router>
