<script>
  import {Link} from 'svelte-routing'
  import Navbar from '@common/Nav.svelte'
  import EventList from './EventList.svelte'
</script>

<style>
  button {
    position: absolute;
    bottom: 25px;
    right: 25px;
    border-radius: 50%;
  }
</style>

<Navbar/>
<div class="container">
  <h1 class="title">Events</h1>
  <EventList/>
</div>
<Link to="create-event">
  <button class="button is-link is-size-4">+</button>
</Link>
