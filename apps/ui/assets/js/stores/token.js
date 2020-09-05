import decode from 'jwt-decode'
import { writable } from 'svelte/store'

const checkExpiration = token => {
  if (token === null) {
    return null
  }

  const { exp } = decode(token)

  if (Date.now() > exp * 1000) {
    return null
  }

  return token
}

const createTokenStore = () => {
  const token = checkExpiration(localStorage.getItem("token"))
  const store = writable(token)

  return {
    subscribe: store.subscribe,
    set(token) {
      localStorage.setItem("token", token)
      return store.set(token)
    }
  }
}

export default createTokenStore()
