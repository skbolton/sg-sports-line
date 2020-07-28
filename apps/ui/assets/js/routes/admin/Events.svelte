<script>
  import {Link} from 'svelte-routing'
  import Navbar from '@common/Nav.svelte'
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
<h1 class="title">Events</h1>
<Link to="create-event">
  <button class="button is-link is-size-4">+</button>
</Link>
