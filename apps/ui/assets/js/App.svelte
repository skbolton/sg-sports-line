<script>
  import { Router, Link, Route } from "svelte-routing"
  import Admin from "./routes/admin/Admin.svelte"

  let url = ""
</script>

<Router url="{url}">
  <Route path="admin/*"component="{Admin}"/>
</Router>
