import axios from 'axios'
import eventClient from './events'
import userClient from './users'
import adminStore from '@stores/admin'

// Create instance
const instance = axios.create({
  baseURL: BASE_URL + '/api'
})

// add interceptors
instance.interceptors.response.use(
  // on success response
  response => response,
  // on failure
  // any 401 should clear user state
  error => {
    if (error.response && error.response.status == 401) {
      adminStore.clearAdmin()
    }

    return error
  }
)

// attach specific model clients
const [ events, users ] = [eventClient, userClient].map(attach => attach(instance))

instance.events = events
instance.users = users

instance.getData = ({ data }) => data

export default instance
