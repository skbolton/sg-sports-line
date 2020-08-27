import decode from 'jwt-decode'

class TokenStorage {
  constructor () {
    const token = localStorage.getItem("token")

    this._token = token && !this.expired(token)
      ? token
      : null
  }

  expired(token) {
    decoded = decode(token)

    return decode.exp
      ? Date.now() > decoded.exp
      : true
  }

  get token() {
    return this._token
  }

  set token(val) {
    this._token = val
    localStorage.setItem("token", val)
  }
}

export default new TokenStorage()
