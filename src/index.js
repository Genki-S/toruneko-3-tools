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

app.ports.clearIdentifiedItemNames.subscribe(function() {
  const result = window.confirm("識別状態をリセットします");
  if (result) {
    localStorage.setItem(identifiedItemNamesKey, JSON.stringify([]));
    // reload to reflect the new localStorage state to Elm app
    location.reload();
  }
});
