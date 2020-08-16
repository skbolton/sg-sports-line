import { attributes } from 'structure'

const Event = attributes({
  id: {
    type: String
  },
  name: {
    type: String,
    required: true
  },
  eventStart: {
    type: Date,
    required: true,
    min: Date.now()
  },
  // should be after the start
  eventEnd: {
    type: Date,
    required: true,
    min: { attr: 'eventStart' }
  },
  // should be before event ends
  sheetOpen: {
    type: Date,
    required: true,
    max: { attr: 'eventEnd' }
  },
  // also before event ends
  sheetClosed: {
    type: Date,
    required: true,
    max: { attr: 'eventEnd' }
  },
  sheetCost: {
    type: Number,
    required: true,
    default: 20,
    integer: true
  },
  fundsGranted: {
    type: Number,
    required: true,
    default: 100,
    integer: true
  }
})(class Event {})

export default Event
