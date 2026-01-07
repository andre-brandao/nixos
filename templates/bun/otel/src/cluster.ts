import { spawn } from 'bun'

const cpus = navigator.hardwareConcurrency // Number of CPU cores
console.log(`Starting ${cpus} Bun server instances...`)
const buns = new Array(cpus)

// const passStd = (type:string) => stream => {

// }

for (let i = 0; i < cpus; i++) {
  buns[i] = spawn({
    cmd: ['bun', './src/index.ts'],
    stdout: 'inherit',
    stderr: 'inherit',
    stdin: 'inherit',
  })
}

function kill() {
  for (const bun of buns) {
    bun.kill()
  }
}

process.on('SIGINT', kill)
process.on('exit', kill)
