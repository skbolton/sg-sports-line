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
  return new Promise(resolve => {
    const unsubscribe = tokenStore.subscribe(token => {
      if (token) {
        config.headers.authorization = `Bearer ${token}`
      }

      resolve(config)
    })
    unsubscribe()
  })
})

instance.graph = (query, variables) => 
  instance
    .post("/", {query: query, variables: variables})
    // axios stores response under data key
    .then(({ data }) => data)
    // graphql stores query response under data key
    .then(({ data }) => data)

export default instance
