/*app.ts*/
const PORT: number = parseInt(process.env.PORT || '8080')
import index from './index.html' with { type: 'text' }
import { trace } from '@opentelemetry/api'
import { rollTheDice } from './dice'

const tracer = trace.getTracer('dice-server', '0.1.0')

const id = Math.random().toString(36).slice(2)

function randomError() {
  const errorChance = Math.random()
  if (errorChance < 0.5) {
    throw new Error('Random error occurred during dice roll!')
  }

  const secondErrorChance = Math.random()
  if (secondErrorChance < 0.05) {
    throw new Error('Another random error occurred during dice roll!')
  }
}
Bun.serve({
  port: PORT,
  // routes: {
  //   '/': index,
  // },
  development: false,
  // Share the same port across multiple processes
  // This is the important part!
  reusePort: true,
  fetch(req) {
    const span = tracer.startSpan('http_request_span')
    const spanContext = span.spanContext()
    span.setAttributes({
      'server.id': id,
      'http.method': req.method,
      'http.url': req.url,
      'http.client_ip':
        req.headers.get('x-forwarded-for') ||
        req.headers.get('remote_addr') ||
        'unknown',
    })
    const traceId = spanContext.traceId
    const spanId = spanContext.spanId
    // const traceId = tracer.startSpan('http_request_span').spanContext().traceId

    // const page = traceRewriter(traceId, spanId)
    try {
      const url = new URL(req.url)
      if (url.pathname === '/rolldice') {
        const rolls = url.searchParams.get('rolls')
        const numRolls = rolls ? parseInt(rolls) : 69
        randomError()
        span.updateName(`rolldice:${numRolls}`)
        return new Response(JSON.stringify(rollTheDice(numRolls, 1, 100)))
      }
    } catch (err) {
      span.setStatus({ code: 2 }) // Set status to Error
      span.setAttribute('error', true)

      if (err instanceof Error) {
        span.recordException(err)
        span.setAttribute('error.message', err.message)
        console.error(err.message)
      } else {
        // span.recordException(err)
        console.error(err)
      }
    } finally {
      span.end()
    }
    span.setAttributes({
      'http.response.content_type': 'text/html',
      'http.response.status_code': 200,
    })
    span.updateName('serve_homepage')
    return new Response(
      `
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <meta name="traceparent" content="00-${traceId}-${spanId}-01" />
          <title>Bun OpenTelemetry Dice Roller</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  margin: 2em;
              }
              input[type="number"] {
                  width: 60px;
              }
              #result {
                  margin-top: 1em;
                  font-weight: bold;
              }
          </style>
      </head>
      <body>
          <h1>Bun OpenTelemetry Dice Roller</h1>
          <label for="rolls">Number of Rolls:</label>
          <input type="number" id="rolls" name="rolls" value="5" min="1" max="1000" />
          <button id="rollButton">Roll Dice</button>
          <div id="result"></div>

          <script>
              document.getElementById('rollButton').addEventListener('click', async () => {
                  const rolls = document.getElementById('rolls').value;
                  const response = await fetch(\`/rolldice?rolls=\${rolls}\`);
                  const data = await response.json();
                  document.getElementById('result').textContent = 'Results: ' + data.join(', ');
              });
          </script>
      </body>
      </html>

      `,
      {
        status: 200,
        headers: { 'Content-Type': 'text/html' },
      },
    )
  },
})

console.log(`Listening for requests on http://localhost:${PORT}`)
