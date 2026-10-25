import { router, useForm, usePage } from '@inertiajs/react'
import Field from '../Field'
import Layout from '../Layout'

function date(iso) {
  return iso ? new Date(iso).toLocaleString() : 'never'
}

export default function ApiKeys({ keys, errors }) {
  const { flash } = usePage()
  const form = useForm({ name: '' })

  function submit(e) {
    e.preventDefault()
    form.post('/api-keys', { onSuccess: () => form.reset() })
  }

  function remove(key) {
    if (confirm(`Delete the key "${key.name}"? Apps that use it stop working.`)) {
      router.delete(`/api-keys/${key.id}`)
    }
  }

  return (
    <Layout title="API keys">
      {flash?.api_key && (
        <div className="card new-key">
          <p>Copy your new key now. You will not see it again.</p>
          <code>{flash.api_key}</code>
        </div>
      )}
      <form className="card" onSubmit={submit}>
        <h2>New API key</h2>
        <Field label="Name" placeholder="my laptop" value={form.data.name} error={errors.name}
          onChange={(e) => form.setData('name', e.target.value)} />
        <button disabled={form.processing}>Create key</button>
      </form>
      <p className="muted">
        Use it as <code>Authorization: Bearer &lt;key&gt;</code>. API docs: <a href="/docs">/docs</a>
      </p>
      {keys.length > 0 && (
        <table>
          <thead><tr><th>Name</th><th>Created</th><th>Last used</th><th /></tr></thead>
          <tbody>
            {keys.map((key) => (
              <tr key={key.id}>
                <td>{key.name}</td>
                <td>{date(key.created_at)}</td>
                <td>{date(key.last_used_at)}</td>
                <td className="actions">
                  <button className="link-button danger" onClick={() => remove(key)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </Layout>
  )
}
