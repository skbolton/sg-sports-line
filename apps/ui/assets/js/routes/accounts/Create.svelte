<script>
  import { navigate } from 'svelte-routing'
  import api from '../../api'
  import adminStore from '../../storage.js'

  let email = ""
  let password = ""
  let passwordConfirmation = ""

  $: submittable = email.length > 0 && password.length > 0 && password === passwordConfirmation

  const createAccount = () => {
    if (!submittable) {
      return
    }

    api.users.create(email, password)
      .then(api.getData)
      .then(() => {
        navigate('/')
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
    <form class="box" on:submit|preventDefault={createAccount}>
      <h1 class="title has-text-black">Create User</h1>
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
          <input class="input" type="password" bind:value={password} placeholder="Confirm Password" on:keypress={event => password = event.target.value}>
          <span class="icon is-small is-left">
            <i class="ri-lock-fill"></i>
          </span>
        </div>
      </div>
      <div class="field mb-5">
        <label class="label">Password</label>
        <div class="control has-icons-left">
          <input class="input" type="password" bind:value={passwordConfirmation} placeholder="Confirm Password" on:keypress={event => passwordConfirmation = event.target.value}>
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

