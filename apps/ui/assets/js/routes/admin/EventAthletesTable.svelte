<script>
  export let eventAthletes
</script>

<table class="table is-fullwidth is-striped is-bordered">
  <thead>
    <tr>
      <th>Name</th>
      <th>Cost</th>
      <th>Winnings</th>
    </tr>
  </thead>
  <tbody>
    {#each eventAthletes as ea}
      <tr>
        <td>{ea.athlete.name}</td>
        <td>{ea.cost}</td>
        <td>{ea.winnings}</td>
      </tr>
    {/each}
  </tbody>
</table>
