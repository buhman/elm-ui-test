import { Main } from './elm/Main.elm'
import './sass/styles.sass'

// non-necessary container div creation

let div = document.createElement('div')
div.setAttribute("id", "main")
document.body.prepend(div)

// app

let app = Main.embed(div)


class ApiError extends Error {
}


async function createFile(file) {
  let fd = new FormData()
  fd.append('c', file)
  fd.append('f', file.name)

  let request = new Request('https://ptpb.pw', {
    method: 'post',
    body: fd,
    headers: new Headers({
      'accept': 'application/json'
    })
  })

  let response = await fetch(request)
  let data = await response.json()

  if (!response.ok)
    throw new ApiError(data.status)

  return data
}


app.ports.createFiles.subscribe(files => {
  // fixme: not sure if we should process an array of files, or just one file
  if (files[0] == undefined) {
    app.ports.createFilesCompleted.send({
      type: "api",
      error: "no file selected"
    })
    return
  }

  createFile(files[0]).then(data => {
    app.ports.createFilesCompleted.send(data)
  }).catch(error => {
    if (error instanceof TypeError) {
      app.ports.createFilesCompleted.send({
        type: "network",
        error: error.message
      })
    } else if (error instanceof ApiError) {
      console.log(typeof error.message)

      app.ports.createFilesCompleted.send({
        type: "api",
        error: error.message
      })
    } else {
      throw error
    }
  })
})
