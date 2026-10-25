import { Link } from '@inertiajs/react'
import Layout from '../Layout'

/** One small bar chart: a pair of bars (clicks, scans) per day. */
function Chart({ daily }) {
  const max = Math.max(1, ...daily.map((d) => Math.max(d.clicks, d.scans)))
  const barWidth = 8
  const gap = 6
  const height = 160
  const width = daily.length * (barWidth * 2 + gap)

  return (
    <svg className="chart" viewBox={`0 0 ${width} ${height + 20}`} role="img"
      aria-label="Clicks and scans per day">
      {daily.map((d, i) => {
        const x = i * (barWidth * 2 + gap)
        const clickHeight = (d.clicks / max) * height
        const scanHeight = (d.scans / max) * height
        return (
          <g key={d.date}>
            <title>{`${d.date}: ${d.clicks} clicks, ${d.scans} scans`}</title>
            <rect x={x} y={height - clickHeight} width={barWidth} height={clickHeight} className="bar-click" />
            <rect x={x + barWidth} y={height - scanHeight} width={barWidth} height={scanHeight} className="bar-scan" />
            {i % 7 === 0 && <text x={x} y={height + 14} className="axis">{d.date.slice(5)}</text>}
          </g>
        )
      })}
    </svg>
  )
}

export default function LinkStats({ link, stats }) {
  return (
    <Layout title={`Stats for ${link.code}`}>
      <p><Link href="/links">&larr; Back to links</Link></p>
      <p className="muted">{link.short_url} &rarr; {link.url}</p>
      <div className="totals">
        <div className="card"><strong>{stats.totals.clicks}</strong> clicks</div>
        <div className="card"><strong>{stats.totals.scans}</strong> scans</div>
      </div>
      <div className="card">
        <p className="legend">
          <span className="dot bar-click" /> clicks <span className="dot bar-scan" /> scans
          <span className="muted"> (last {stats.days} days, UTC)</span>
        </p>
        <Chart daily={stats.daily} />
      </div>
    </Layout>
  )
}
