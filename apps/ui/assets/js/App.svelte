<script>
  import { Router, Link, Route } from "svelte-routing"
  import Admin from "./routes/admin/Admin.svelte"
  import Accounts from "./routes/accounts/Accounts.svelte"

  let url = ""
</script>

<Router url="{url}">
  <Route path="admin/*"component="{Admin}"/>
  <Route path="accounts/*"component="{Accounts}"/>
</Router>
