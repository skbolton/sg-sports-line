<script>
  import { url } from '@sveltech/routify'
  import Logo from '@common/Logo.svelte'

  export let home = '/'
  let open = false

</script>

<style>
  nav {
    margin-bottom: 24px;
  }
</style>

<nav class="navbar">
  <section class="navbar-brand has-text-white">
    <a class="navbar-item" href={$url(home)}><Logo/></a>
      <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" on:click={() => open = !open}>
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
    </a>
  </section>
  <section class="navbar-menu" class:is-active={open}>
    <div class="navbar-start"></div>
    <div class="navbar-end">
      <div class="navbar-item">
        <a class:has-text-white={!open} href={$url("/admin")}>
          Admin
        </a>
      </div>
    </div>
  </section>
</nav>
