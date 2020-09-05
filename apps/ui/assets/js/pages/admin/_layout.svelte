<script>
  import { url } from '@sveltech/routify'
  import adminStore from '@stores/admin'

</script>

{#if $adminStore}
  <slot></slot>
{:else}
  <div class="hero is-large">
    <div class="hero-body">
      <div class="container">
        <h1 class="title has-text-centered">
          You must be an admin to see this content
        </h1>
        <div class="subtitle has-text-centered">
          Try <a href={$url("/login")}>logging</a> in
        </div>
      </div>
    </div>
  </div>
{/if}
