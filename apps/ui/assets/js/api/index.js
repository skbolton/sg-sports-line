import axios from 'axios'
import tokenStore from '@stores/token'

// Create instance
const instance = axios.create({
  baseURL: BASE_URL + '/graph'
})

/*
 * Interceptors
 */

// Request
instance.interceptors.request.use(config => {
  const token = tokenStore.token
  if (token) {
    config.headers.authorization = `Bearer ${token}`
  }
  return config
})

instance.graph = (query, variables) => 
  instance
    .post("/", {query: query, variables: variables})
    // axios stores response under data key
    .then(({ data }) => data)
    // graphql stores query response under data key
    .then(({ data }) => data)

export default instance
