<script>
  import { navigate } from 'svelte-routing'
  export let page = 'details'
  export let id

  const goTo = tab => () => {
    navigate(`/admin/event/${id}/${tab}`)
  }
</script>

<div class="tabs">
  <ul>
    <li class:is-active={page === "details"}>
      <a on:click={goTo("details")}>
        <span class="icon is-small"><i class="ri-information-line"></i></span>
        <span>
          Details
        </span>
      </a>
    </li>
    <li class:is-active={page === "athletes"}>
      <a on:click={goTo("athletes")}>
        <span class="icon is-small"><i class="ri-shield-user-line"></i></span>
        <span>
          Athletes
        </span>
      </a>
    </li>
    <li class:is-active={page === "sheets"}>
      <a on:click={goTo("sheets")}>
        <span class="icon is-small"><i class="ri-file-list-line"></i></span>
        <span>
          Sheets
        </span>
      </a>
    </li>
  </ul>
</div>
