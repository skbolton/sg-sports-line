import { attributes } from 'structure'

const Login = attributes({
  email: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  }
})(class Login {})

export default Login
