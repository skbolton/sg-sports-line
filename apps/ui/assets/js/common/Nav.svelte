<script>
  import { url } from '@sveltech/routify'
  import Logo from '@common/Logo.svelte'

  let open = false
</script>

<nav class="navbar mb-6">
  <section class="navbar-brand has-text-white">
    <a class="navbar-item" href={$url("/")}><Logo/></a>
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
