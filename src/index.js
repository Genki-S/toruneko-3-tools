import './main.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const identifiedItemNamesKey = 'identifiedItemNames'

const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    identifiedItemNames: JSON.parse(localStorage.getItem(identifiedItemNamesKey)) || [],
  }
});

registerServiceWorker();

app.ports.storeIdentifiedItemNames.subscribe(function(itemNames) {
  localStorage.setItem(identifiedItemNamesKey, JSON.stringify(itemNames));
});
