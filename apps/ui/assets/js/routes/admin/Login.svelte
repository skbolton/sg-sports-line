<script>
  import { navigate } from 'svelte-routing'
  import api from '@api'
  import decodeJwt from 'jwt-decode'
  import adminStore from '@stores/admin'
  import tokenStore from '@stores/token'

  let email = ""
  let password = ""

  $: submittable = email.length > 0 && password.length > 0

  const loginQuery = `
    mutation requestAuthToken($email: String! $password: String!) {
      requestAuthToken(email: $email password: $password) {
        token
      }
    }
  `

  const login = () => {
    if (!submittable) {
      return
    }

    api.graph(loginQuery, { email: email, password: password })
      .then(({ requestAuthToken }) => {
        const { token } = requestAuthToken
        const {admin = false} = decodeJwt(token)
        adminStore.storeAdmin(admin)
        tokenStore.token = token
        navigate('/admin/')
      })
  }

</script>

<style>
  form {
    width: 33%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<section class="hero is-link is-fullheight">
  <div class="hero-body aic jcc">
    <form class="box" on:submit|preventDefault={login}>
      <h1 class="title has-text-black">Admin Panel</h1>
      <div class="field mb-5">
        <label class="label">Email</label>
        <div class="control has-icons-left">
          <input autofocus class="input" type="text" bind:value={email} placeholder="Email" on:keypress={event => email = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-user-fill"></i>
          </span>
        </div>
      </div>
      <div class="field mb-5">
        <label class="label">Password</label>
        <div class="control has-icons-left">
          <input class="input" type="password" bind:value={password} placeholder="Password" on:keypress={event => password = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-lock-fill"></i>
          </span>
        </div>
      </div>
      <div class="field mb-5">
        <div class="control">
          <input type="submit" disabled={!submittable} value="Log in" class="button is-link">
        </div>
      </div>
    </form>
  </div>
</section>

