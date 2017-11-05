import { Main } from './elm/Main.elm'
import './sass/styles.sass'

// non-necessary container div creation

let div = document.createElement('div')
div.setAttribute("id", "main")
document.body.prepend(div)

// app

let app = Main.embed(div)

app.ports.files.subscribe(function(value) {
  console.log("wats this", value);
});
