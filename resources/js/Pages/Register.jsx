import { Link, useForm } from '@inertiajs/react'
import Field from '../Field'
import Layout from '../Layout'

export default function Register({ errors }) {
  const form = useForm({ name: '', email: '', password: '', password_confirmation: '' })

  function submit(e) {
    e.preventDefault()
    form.post('/register', { onFinish: () => form.reset('password', 'password_confirmation') })
  }

  function set(key) {
    return (e) => form.setData(key, e.target.value)
  }

  return (
    <Layout title="Sign up">
      <form className="card narrow" onSubmit={submit}>
        <Field label="Name" value={form.data.name} error={errors.name} onChange={set('name')} />
        <Field label="Email" type="email" value={form.data.email} error={errors.email} onChange={set('email')} />
        <Field label="Password" type="password" value={form.data.password} error={errors.password}
          onChange={set('password')} />
        <Field label="Password again" type="password" value={form.data.password_confirmation}
          error={errors.password_confirmation} onChange={set('password_confirmation')} />
        <button disabled={form.processing}>Create account</button>
        <p className="muted">Have an account? <Link href="/login">Log in</Link></p>
      </form>
    </Layout>
  )
}
