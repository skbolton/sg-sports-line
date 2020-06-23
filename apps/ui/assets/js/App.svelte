<script>
  let count = 0

  const increment = () => count++
  const decrement = () => count--
</script>

<h1 class="title">
  Hello World, from Svelte!
</h1>
<p>The Count is currently: {count}</p>
<button on:click={increment} class="button is-primary">+</button>
<button on:click={decrement} class="button is-warning">-</button>
