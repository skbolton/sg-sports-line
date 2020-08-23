<script>
  import { isActive, url } from '@sveltech/routify'
  import { navigate } from 'svelte-routing'
  export let id

</script>

<div class="tabs is-boxed">
  <ul>
    <li class:is-active={$isActive('./details')}>
      <a href={$url('./details')}>
        <span class="icon is-small"><i class="ri-information-line"></i></span>
        <span>
          Details
        </span>
      </a>
    </li>
    <li class:is-active={$isActive('./athletes')}>
      <a href={$url('./athletes')}>
        <span class="icon is-small"><i class="ri-shield-user-line"></i></span>
        <span>
          Athletes
        </span>
      </a>
    </li>
    <li class:is-active={$isActive('./sheets')}>
      <a href={$url('./sheets')}>
        <span class="icon is-small"><i class="ri-file-list-line"></i></span>
        <span>
          Sheets
        </span>
      </a>
    </li>
  </ul>
</div>
