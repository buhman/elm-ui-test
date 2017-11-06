import { Main } from './elm/Main.elm'
import './sass/styles.sass'

// non-necessary container div creation

let div = document.createElement('div')
div.setAttribute("id", "main")
document.body.prepend(div)

// app

let app = Main.embed(div)

app.ports.createFiles.subscribe((files) => {
  // fixme: not sure if we should process an array of files, or just one file
  console.assert(files[0] != undefined)

  let fd = new FormData()
  fd.append('c', files[0])

  let request = new Request('https://ptpb.pw/', {
    method: 'post',
    body: fd,
    headers: new Headers({
      'accept': 'application/json'
    })
  })

  fetch(request).then((response) => {
    return response.json()
  }).then((data) => {
    app.ports.createFilesCompleted.send(data)
  })
})
