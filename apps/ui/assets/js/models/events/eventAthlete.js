import { attributes } from 'structure'

const EventAthlete = attributes({
  cost: {
    type: Number,
    required: true,
    integer: true,
    positive: true
  },
  winnings: {
    type: Number,
    min: 0,
    default: 0
  }
})(class EventAthlete {})

export default EventAthlete
