<script>
  import { url } from '@sveltech/routify'
  import Logo from '@common/Logo.svelte'

</script>

<style>
  nav {
    margin-bottom: 24px;
  }
</style>

<nav class="navbar is-dark">
  <section class="navbar-brand has-text-white">
    <a class="navbar-item" href={$url("/")}><Logo/></a>
  </section>
</nav>
