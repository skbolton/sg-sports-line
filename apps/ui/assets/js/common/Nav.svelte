<script>
  import Logo from '@common/Logo.svelte'
  import {navigate} from 'svelte-routing'

  export let url = ''
</script>

<style>
  nav {
    margin-bottom: 24px;
  }
</style>

<nav class="navbar">
  <section class="navbar-brand has-text-white">
    <div class="navbar-item" on:click={() => navigate(url)}><Logo/></div>
  </section>
</nav>
