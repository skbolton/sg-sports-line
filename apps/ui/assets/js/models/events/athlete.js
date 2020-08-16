import { attributes } from 'structure'

const Athlete = attributes({
  name: {
    type: String,
    required: true
  }
})(class Athlete {})

export default Athlete
