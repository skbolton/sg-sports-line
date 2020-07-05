<script>
  import { Router, Link, Route } from "svelte-routing"
  import Login from "./routes/admin/Login.svelte"

  let url = ""
</script>

<Router url="{url}">
  <Route path="admin/login"component="{Login}"/>
</Router>
