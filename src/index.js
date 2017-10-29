import { Main } from './elm/Main.elm'
import './sass/styles.sass'

let div = document.createElement('div')
div.setAttribute("id", "main")
document.body.prepend(div)

Main.embed(div)
