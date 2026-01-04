import { SizeHint, Webview } from 'webview-bun'

const webview = new Webview(false, {
  height: 600,
  width: 800,
  hint: SizeHint.FIXED,
})
// webview.setHTML(`
//   <!DOCTYPE html>
//   <html>
//   <head>
//     <title>Hello World</title>
//   </head>
//   <body>
//     <h1>Hello World</h1>
//   </body>
//   </html>
//   `)
webview.navigate('https://bun.sh')

webview.run()
