import { writable } from 'svelte/store'

const {subscribe, set} = writable(localStorage.getItem("admin") || false)

const adminStore = {
  subscribe,
  storeAdmin (isAdmin) {
    localStorage.setItem("admin", isAdmin)
    set(isAdmin)
  },
  clearAdmin() {
    localStorage.setItem("admin", false)
    set(false)
  }
}

export default adminStore
