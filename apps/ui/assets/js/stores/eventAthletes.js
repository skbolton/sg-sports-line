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
      availableAthletes {
        name
        id
      }
    }
  }
`

const ADD_ATHELETE_QUERY = `
  mutation addAthlete($eventId: ID!, $athleteId: ID!, $cost: Float!) {
    addAthleteToEvent(athleteId: $athleteId, eventId: $eventId, cost: $cost) {
      eventAthletes {
        id
        cost
        winnings
        athlete {
          name
        }
      }
      availableAthletes {
        name
        id
      }
    }
  }
`

const UPDATE_ATHLETE_QUERY = `
 mutation updateEventAthlete($id: ID!, $cost: Float!, $winnings: Float!) {
   updateEventAthlete(id: $id, cost: $cost, winnings: $winnings) {
     id
   }
 }
`

const REMOVE_ATHLETE_QUERY = `
  mutation removeEventAthlete($id: ID!) {
    removeEventAthlete(id: $id) {
      eventAthletes {
        id
        cost
        winnings
        athlete {
          name
        }
      }
      availableAthletes {
        name
        id
      }
    }
  }
`

const createEventAthleteStore = () => {
  const { subscribe, update} = writable({loading: false, eventAthletes: [], availableAthletes: [], pendingAthletes: []})

  return {
    subscribe,
    getAthletes(eventId) {
      update(store => ({...store, loading: true}))
      return api.graph(ATHLETES_QUERY, {id: eventId})
        .then(({ event }) => event)
        .then(({ eventAthletes, availableAthletes }) => update(store => ({...store, eventAthletes, availableAthletes })))
        .finally(() => update(store => ({...store, loading: false})))
    },
    addAthlete({ eventId, athleteId, cost }) {
      update(store => ({ ...store, loading: true }))
      return api.graph(ADD_ATHELETE_QUERY, { eventId, athleteId, cost })
        .then(({ addAthleteToEvent }) => addAthleteToEvent)
        .then(({ eventAthletes, availableAthletes }) => update(store => {
          const pendingAthletes = store.pendingAthletes.filter(athlete => athlete.id !== athleteId)

          return { 
            ...store,
            pendingAthletes,
            eventAthletes,
            availableAthletes
          }
        }))
        .finally(() => update(store => ({ ...store, loading: false })))
    },
    selectAthleteToAdd(athlete) {
      return update(store => {
        const availableAthletes = store.availableAthletes.filter(available => available.id !== athlete.id)
        const pendingAthletes = [...store.pendingAthletes, athlete]

        return {
          ...store,
          availableAthletes,
          pendingAthletes
        }
      })
    },
    updateAthlete({ id, cost, winnings }) {
      return api.graph(UPDATE_ATHLETE_QUERY, { id, cost, winnings })
        .then(() =>
          update(store => ({
            ...store,
            eventAthletes: store.eventAthletes.map(athlete => athlete.id === id ? { ...athlete, cost, winnings } : athlete)
          }))
        )
    },
    removeAthlete({ id }) {
      return api.graph(REMOVE_ATHLETE_QUERY, { id })
        .then(({ removeEventAthlete }) => removeEventAthlete)
        .then(({ eventAthletes, availableAthletes }) => update(store => ({ ...store, eventAthletes, availableAthletes })))
    }
  }
}

const eventAthleteStore = createEventAthleteStore()

export default eventAthleteStore
