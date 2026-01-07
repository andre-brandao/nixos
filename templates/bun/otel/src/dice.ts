/*dice.ts*/
import { trace, type Span } from '@opentelemetry/api'
const tracer = trace.getTracer('dice-lib')

function rollOnce(i: number, min: number, max: number) {
  return tracer.startActiveSpan(`rollOnce:${i}`, (span: Span) => {
    const result = Math.floor(Math.random() * (max - min + 1) + min)

    // Add an attribute to the span
    span.setAttribute('dicelib.rolled', result.toString())

    span.end()
    return result
  })
}
export function rollTheDice(rolls: number, min: number, max: number) {
  // Create a span. A span must be closed.
  return tracer.startActiveSpan('rollTheDice', (span: Span) => {
    const result: number[] = []
    for (let i = 0; i < rolls; i++) {
      span.setAttribute('roll.number', i + 1)
      result.push(rollOnce(i, min, max))
    }
    // Be sure to end the span!
    span.end()
    return result
  })
}
