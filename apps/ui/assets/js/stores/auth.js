import { writable } from 'svelte/store'
import decodeJwt from 'jwt-decode'
import api from '@api'
import tokenStore from './token'
import adminStore from '@stores/admin'

const LOGIN_QUERY = `
  mutation requestAuthToken($email: String! $password: String!) {
    requestAuthToken(email: $email password: $password) {
      token
    }
  }
`

const createAuthStore = () => {
  const { subscribe, update } = writable({loading: false, token: tokenStore.token})

  return {
    subscribe,
    login(email, password) {
      update(store => ({...store, loading: true}))

      return api.graph(LOGIN_QUERY, { email, password })
        .then(({ requestAuthToken }) => {
          const { token } = requestAuthToken
          const {admin = false} = decodeJwt(token)
          adminStore.storeAdmin(admin)
          tokenStore.token = token

          update(store => ({ ...store, token: tokenStore.token}))
        })
    }
  }
}

const authStore = createAuthStore()

export default authStore

