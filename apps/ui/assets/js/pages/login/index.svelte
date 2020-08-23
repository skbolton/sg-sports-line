<script>
  import { goto, redirect } from '@sveltech/routify'
  import { navigate } from 'svelte-routing'
  import { onMount } from 'svelte'
  import authStore from '@stores/auth'
  import Login from '../../models/login'

  let login = new Login({email: "", password: ""})

  $: submittable = login.validate().valid

  onMount(() => {
    if ($authStore.token) {
      $redirect("/")
    }
  })

  const submit = () => {
    if (!submittable) {
      return
    }

    authStore.login(login.email, login.password)
      .then(() => $goto("/"))
  }

</script>

<style>
  form {
    width: 33%;
    min-width: 400px;
    max-width: 800px;
  }
</style>

<section class="hero is-fullheight">
  <div class="hero-body aic jcc">
    <form class="box" on:submit|preventDefault={submit}>
      <h1 class="title">Admin Panel</h1>
      <div class="field mb-5">
        <label class="label">Email</label>
        <div class="control has-icons-left">
          <input autofocus class="input" type="text" bind:value={login.email} placeholder="Email" on:keypress={({ target }) => login.email = target.value}>
          <span class="icon is-small is-left">
            <i class="ri-user-fill"></i>
          </span>
        </div>
      </div>
      <div class="field mb-5">
        <label class="label">Password</label>
        <div class="control has-icons-left">
          <input class="input" type="password" bind:value={login.password} placeholder="Password" on:keypress={({ target }) => login.password = target.value}>
          <span class="icon is-small is-left">
            <i class="ri-lock-fill"></i>
          </span>
        </div>
      </div>
      <div class="field mb-5">
        <div class="control">
          <button type="submit" disabled={!submittable} class:is-loading={$authStore.loading} class="button is-primary">Log in</button>
        </div>
      </div>
    </form>
  </div>
</section>

