import { Link, useForm } from '@inertiajs/react'
import Field from '../Field'
import Layout from '../Layout'

export default function Login({ errors }) {
  const form = useForm({ email: '', password: '' })

  function submit(e) {
    e.preventDefault()
    form.post('/login', { onFinish: () => form.reset('password') })
  }

  return (
    <Layout title="Log in">
      <form className="card narrow" onSubmit={submit}>
        <Field label="Email" type="email" value={form.data.email} error={errors.email}
          onChange={(e) => form.setData('email', e.target.value)} />
        <Field label="Password" type="password" value={form.data.password} error={errors.password}
          onChange={(e) => form.setData('password', e.target.value)} />
        <button disabled={form.processing}>Log in</button>
        <p className="muted">No account? <Link href="/register">Sign up</Link></p>
      </form>
    </Layout>
  )
}
