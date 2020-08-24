import { writable } from 'svelte/store'
import api from '@api'

const CREATE_ATHLETE_QUERY = `
  mutation createAthlete($name: String!) {
    createAthlete(name: $name) {
      id
      name
    }
  }
`

const createAthleteStore = () => {
  const store = writable({ loading: false, athlete: null })

  return {
    subscribe: store.subscribe,
    createAthlete(name) {
      store.update(store => ({...store, loading: true}))
      return api.graph(CREATE_ATHLETE_QUERY, { name })
        .then(({ createAthlete }) => createAthlete)
        .then(athlete => store.update(store => ({...store, athlete})))
        .finally(() => store.update(store => ({...store, loading: false})))
    }
  }
}

const athleteStore = createAthleteStore()

export default athleteStore
