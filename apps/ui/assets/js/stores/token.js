class TokenStorage {
  constructor () {
    this._token = localStorage.getItem("token") || null
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
