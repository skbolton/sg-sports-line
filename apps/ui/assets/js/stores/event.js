import { writable } from 'svelte/store'
import api from '@api'
import Event from '../models/events/event'

const EVENT_QUERY = `
  query eventById($id: ID!) {
    event(id: $id) {
      id
      name
      eventStart
      eventEnd
      sheetOpen
      sheetClosed
      sheetCost
      fundsGranted
    }
  }
`

const UPDATE_EVENT_DETAILS_QUERY = `
    mutation updateEvent($id: ID!, $name: String, $eventStart: DateTime, $eventEnd: DateTime, $sheetOpen: DateTime, $sheetClosed: DateTime, $sheetCost: Int, $fundsGranted: Int) {
      updateEvent(id: $id, name: $name, eventStart: $eventStart, eventEnd: $eventEnd, sheetOpen: $sheetOpen, sheetClosed: $sheetClosed, sheetCost: $sheetCost, fundsGranted: $fundsGranted) {
          id
          name
          eventStart
          eventEnd
          sheetOpen
          sheetClosed
          sheetCost
          fundsGranted
        }
    }
`

const createEventStore = () => {
  const { subscribe, update } = writable({loading: false, event: null})

  return {
    subscribe,
    getById(id) {
      update(store => ({...store, loading: true}))
      return api.graph(EVENT_QUERY, { id })
        .then(({ event }) =>
          update(store => ({...store, event: new Event(event)}))
        )
        .finally(() => update(store => ({...store, loading: false})))
    },
    updateDetails(event) {
      update(store => ({...store, loading: true}))

      return api.graph(UPDATE_EVENT_DETAILS_QUERY, {id: event.id, ...event.toJSON()})
        .then(({ updateEvent }) => {
          update(store => ({...store, event: new Event(updateEvent)}))
        })
        .finally(() => {
          return update(store => ({...store, loading: false}))
        })
        
    }
  }
}

const eventStore = createEventStore()

export default eventStore
