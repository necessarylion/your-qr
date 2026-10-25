import { createInertiaApp } from '@inertiajs/react'
import { createRoot } from 'react-dom/client'
import '../css/app.css'

const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })

function resolve(name) {
  return pages[`./Pages/${name}.jsx`]
}

function setup({ el, App, props }) {
  createRoot(el).render(<App {...props} />)
}

createInertiaApp({ title: titleOf, resolve, setup })

function titleOf(title) {
  return title ? `${title} - Your QR` : 'Your QR'
}
