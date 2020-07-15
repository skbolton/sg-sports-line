import axios from 'axios'
import eventClient from './events'
import userClient from './users'
import adminStore from '../storage'

// Create instance
const instance = axios.create({
  baseURL: 'http://localhost:4000/api'
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
  }
)

// attach specific model clients
const [ events, users ] = [eventClient, userClient].map(attach => attach(instance))

instance.events = events
instance.users = users

instance.getData = ({ data }) => data

export default instance
