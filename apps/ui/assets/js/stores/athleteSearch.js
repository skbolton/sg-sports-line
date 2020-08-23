import { writable } from 'svelte/store'
import api from '@api'

const ATHLETE_SEARCH_QUERY = `
  query athleteSearch($search: String!) {
    athleteByName(search: $search, fuzzy: true) {
      id
      name
    }
  }
`

const createAthleteSearchStore = () => {
  const store = writable({ loading: false, results: [] })

  return {
    subscribe: store.subscribe,
    search(term) {
      store.update(store => ({ ...store, loading: true }))
      return api.graph(ATHLETE_SEARCH_QUERY, { search: term })
        .then(({ athleteByName }) => athleteByName)
        .then(results => store.update(store => ({ ...store, results })))
        .finally(() => store.update(store => ({ ...store, loading: false })))
    },
    clearSearch() {
      return store.set({ loading: false, results: [] })
    }
  }
}

const athleteSearchStore = createAthleteSearchStore()

export default athleteSearchStore
