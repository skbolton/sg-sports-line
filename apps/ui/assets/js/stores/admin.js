import { derived } from 'svelte/store'
import decode from 'jwt-decode'
import tokenStore from '@stores/token'

const adminStore = derived(tokenStore, $token => {
  if ($token) {
    const { admin = false } = decode($token)

    return admin
  }

  return false
})

export default adminStore
