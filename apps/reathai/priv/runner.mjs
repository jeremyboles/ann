import { createInterface } from 'readline'

//
// Settings and constants
// -------------------------------------------------------------------------------------------------

const CHUNK_SIZE = parseInt(process.env.CHUNK_SIZE, 10)

//
// Main function
// -------------------------------------------------------------------------------------------------

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
})

readline.on('line', async (line) => {
  const args = JSON.parse(line)
  const result = await run(args)

  const buffer = Buffer.from(`${JSON.stringify(result)}\n`)
  for (let i = 0; i < buffer.length; i += CHUNK_SIZE) {
    const chunk = buffer.slice(i, i + CHUNK_SIZE)
    process.stdout.write(chunk)
  }
})

//
// Private functions
// -------------------------------------------------------------------------------------------------

async function run({ args = [], functionName = 'default', moduleName }) {
  const mod = await import(`${process.env.NODE_PATH}/${moduleName}.mjs`)
  const func = mod[functionName]

  return await func(...args)
}
