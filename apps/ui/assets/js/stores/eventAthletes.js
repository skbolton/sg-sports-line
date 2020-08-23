import { writable } from 'svelte/store'
import api from '@api'
// import EventAthlete from '../models/events/eventAthlete'

const ATHLETES_QUERY = `
  query event($id: ID!){
    event(id: $id) {
      eventAthletes {
        id
        cost
        winnings
        athlete {
          name
        }
      }
    }
  }
`

const ADD_ATHELETE_QUERY = `
  mutation addAthlete($eventId: ID!, $athleteId: ID!, $cost: Int!) {
    addAthleteToEvent(athleteId: $athleteId, eventId: $eventId, cost: $cost) {
      eventAthletes {
        id
        cost
        winnings
        athlete {
          name
        }
      }
    }
  }
`

const createEventAthleteStore = () => {
  const { subscribe, update} = writable({loading: false, eventAthletes: []})

  return {
    subscribe,
    getAthletes(eventId) {
      update(store => ({...store, loading: true}))
      return api.graph(ATHLETES_QUERY, {id: eventId})
        .then(({ event }) => event)
        .then(({ eventAthletes }) => update(store => ({...store, eventAthletes })))
        .finally(() => update(store => ({...store, loading: false})))
    },
    addAthlete({ eventId, athleteId, cost }) {
      update(store => ({ ...store, loading: true }))
      return api.graph(ADD_ATHELETE_QUERY, { eventId, athleteId, cost })
        .then(({ addAthleteToEvent }) => addAthleteToEvent)
        .then(eventAthletes => update(store => ({ ...store, eventAthletes })))
        .finally(() => update(store => ({ ...store, loading: false })))
    }
  }
}

const eventAthleteStore = createEventAthleteStore()

export default eventAthleteStore
