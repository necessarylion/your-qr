import { Link, router, useForm } from '@inertiajs/react'
import { useState } from 'react'
import Field from '../Field'
import Layout from '../Layout'

/** ISO time from the server -> value for <input type="datetime-local"> (local time). */
function toLocalInput(iso) {
  if (!iso) return ''
  const d = new Date(iso)
  d.setMinutes(d.getMinutes() - d.getTimezoneOffset())
  return d.toISOString().slice(0, 16)
}

/** Form values -> request body. Empty optional fields become null. */
function toBody(data) {
  return {
    url: data.url,
    code: data.code || null,
    title: data.title || null,
    expires_at: data.expires_at ? new Date(data.expires_at).toISOString() : null,
  }
}

function LinkFields({ form, errors }) {
  function set(key) {
    return (e) => form.setData(key, e.target.value)
  }
  return (
    <div className="grid">
      <Field label="Long URL" type="url" placeholder="https://example.com/a/long/page" required
        value={form.data.url} error={errors.url} onChange={set('url')} />
      <Field label="Custom code (optional)" placeholder="my-code" value={form.data.code}
        error={errors.code} onChange={set('code')} />
      <Field label="Title (optional)" value={form.data.title} error={errors.title} onChange={set('title')} />
      <Field label="Expires (optional)" type="datetime-local" value={form.data.expires_at}
        error={errors.expires_at} onChange={set('expires_at')} />
    </div>
  )
}

function CreateForm({ errors }) {
  const form = useForm({ url: '', code: '', title: '', expires_at: '' })

  function submit(e) {
    e.preventDefault()
    form.transform(toBody)
    form.post('/links', { onSuccess: () => form.reset() })
  }

  return (
    <form className="card" onSubmit={submit}>
      <h2>New short link</h2>
      <LinkFields form={form} errors={errors} />
      <button disabled={form.processing}>Create</button>
    </form>
  )
}

function EditForm({ link, errors, onDone }) {
  const form = useForm({
    url: link.url,
    code: link.code,
    title: link.title || '',
    expires_at: toLocalInput(link.expires_at),
  })

  function submit(e) {
    e.preventDefault()
    // the code can not be empty when editing, so always send it
    form.transform((data) => ({ ...toBody(data), code: data.code }))
    form.put(`/links/${link.id}`, { errorBag: 'edit', onSuccess: onDone })
  }

  return (
    <form className="card" onSubmit={submit}>
      <h2>Edit {link.code}</h2>
      <LinkFields form={form} errors={errors.edit || {}} />
      <button disabled={form.processing}>Save</button>{' '}
      <button type="button" className="secondary" onClick={onDone}>Cancel</button>
    </form>
  )
}

function QrPreview({ link, onClose }) {
  const src = `/links/${link.id}/qr.svg`
  return (
    <div className="card qr">
      <img src={src} width="200" height="200" alt={`QR code for ${link.short_url}`} />
      <div>
        <p>Scans open <code>{link.qr_url}</code>, so each scan is counted.</p>
        <a className="button" href={`${src}?download=1`} download={`qr-${link.code}.svg`}>Download SVG</a>{' '}
        <button type="button" className="secondary" onClick={onClose}>Close</button>
      </div>
    </div>
  )
}

export default function Links({ links, errors }) {
  const [editing, setEditing] = useState(null)
  const [qr, setQr] = useState(null)

  function remove(link) {
    if (confirm(`Delete ${link.code}? Its visits are deleted too.`)) {
      router.delete(`/links/${link.id}`)
    }
  }

  return (
    <Layout title="Links">
      {editing ? (
        <EditForm link={editing} errors={errors} onDone={() => setEditing(null)} />
      ) : (
        <CreateForm errors={errors} />
      )}
      {qr && <QrPreview link={qr} onClose={() => setQr(null)} />}
      {links.length === 0 ? (
        <p className="muted">No links yet. Make your first one above.</p>
      ) : (
        <table>
          <thead>
            <tr><th>Code</th><th>Short URL</th><th>Title</th><th>Clicks</th><th>Scans</th><th /></tr>
          </thead>
          <tbody>
            {links.map((link) => (
              <tr key={link.id}>
                <td><code>{link.code}</code></td>
                <td><a href={link.short_url} target="_blank" rel="noreferrer">{link.short_url}</a></td>
                <td>{link.title}</td>
                <td>{link.clicks}</td>
                <td>{link.scans}</td>
                <td className="actions">
                  <button className="link-button" onClick={() => setQr(link)}>QR</button>
                  <Link href={`/links/${link.id}/stats`}>Stats</Link>
                  <button className="link-button" onClick={() => setEditing(link)}>Edit</button>
                  <button className="link-button danger" onClick={() => remove(link)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </Layout>
  )
}
