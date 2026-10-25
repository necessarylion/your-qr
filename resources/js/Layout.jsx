import { Head, Link, router, usePage } from '@inertiajs/react'

function logout() {
  router.post('/logout')
}

/** Page frame: title, nav bar and the flash message. */
export default function Layout({ title, children }) {
  const { auth } = usePage().props
  const { flash } = usePage()
  const user = auth?.user

  return (
    <>
      <Head title={title} />
      <nav className="nav">
        <Link href="/" className="brand">Your QR</Link>
        {user ? (
          <>
            <Link href="/links">Links</Link>
            <Link href="/api-keys">API keys</Link>
            <span className="spacer" />
            <span className="muted">{user.name}</span>
            <button className="link-button" onClick={logout}>Log out</button>
          </>
        ) : (
          <>
            <span className="spacer" />
            <Link href="/login">Log in</Link>
            <Link href="/register">Sign up</Link>
          </>
        )}
      </nav>
      <main className="page">
        <h1>{title}</h1>
        {flash?.message && <p className="flash">{flash.message}</p>}
        {children}
      </main>
    </>
  )
}
