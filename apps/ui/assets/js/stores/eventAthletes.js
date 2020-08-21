import { writable } from 'svelte/store'
import api from '@api'
// import EventAthlete from '../models/events/eventAthlete'

const ATHLETES_QUERY = `
  query event($id: ID!){
    event(id: $id) {
      eventAthletes {
        cost
        athlete {
          name
        }
      }
    }
  }
`

const createEventStore = () => {
  const { subscribe, update} = writable({loading: false, eventAthletes: []})

  return {
    subscribe,
    getAthletes(eventId) {
      update(store => ({...store, loading: true}))
      return api.graph(ATHLETES_QUERY, {id: eventId})
        .then(({ event }) => event)
        .then(({ eventAthletes }) => update(store => ({...store, eventAthletes })))
        .finally(() => update(store => ({...store, loading: false})))
    }
  }
}

const eventStore = createEventStore()

export default eventStore
