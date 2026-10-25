/** A labeled input with its validation error. */
export default function Field({ label, error, ...input }) {
  return (
    <label className="field">
      <span>{label}</span>
      <input {...input} />
      {error && <small className="error">{error}</small>}
    </label>
  )
}
