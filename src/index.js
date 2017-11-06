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
  if (files[0] == undefined) {
    app.ports.createFilesCompleted.send({
      type: "api",
      error: "no file selected"
    })
    return
  }

  let fd = new FormData()
  fd.append('c', files[0])

  console.log("here", files[0])

  let request = new Request('https://ptpb.pw/f', {
    method: 'post',
    body: fd,
    headers: new Headers({
      'accept': 'application/json'
    })
  })

  fetch(request).then((response) => {
    // XXX: what happens if invalid json?
    return response.json().then((data) => {
      if (!response.ok)
        app.ports.createFilesCompleted.send({
          type: "api",
          // hack: this is only to be consistent for now; (also it looks kindof edgy/cool)
          //  -- instead ApiError should be represented by a StatusResponse
          error: JSON.stringify(data)
        })
      else
        app.ports.createFilesCompleted.send(data)
    })
  }).catch((error) => {
    app.ports.createFilesCompleted.send({
      type: "network",
      error: error.message
    })
  })
})
