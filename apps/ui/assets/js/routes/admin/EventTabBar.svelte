<script>
  export let page = 'athletes'
</script>

<div class="tabs is-boxed">
  <ul>
    <li class:is-active={page === "athletes"}>
      <a>
        <span class="icon is-small"><i class="ri-shield-user-line"></i></span>
        <span>
          Athletes
        </span>
      </a>
    </li>
    <li class:is-active={page === "sheets"}>
      <a>
        <span class="icon is-small"><i class="ri-file-list-line"></i></span>
        <span>
          Sheets
        </span>
      </a>
    </li>
  </ul>
</div>
